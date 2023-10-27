# Copyright (c) 2007-2023 Andy Maleh
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

if ARGV.include?('--bundler') && File.exist?(File.expand_path('./Gemfile'))
  require 'bundler'
  Bundler.setup(:default)
end
require 'fileutils'
require 'os'

module Glimmer
  # Launcher of glimmer applications and main entry point for the `glimmer` command.
  class Launcher
    # TODO update the verbiage below for Glimmer DSL for LibUI
    TEXT_USAGE = <<~MULTI_LINE_STRING
      Glimmer DSL for LibUI (Prerequisite-Free Ruby Desktop Development Cross-Platform Native GUI Library) - Ruby Gem: glimmer-dsl-libui v#{File.read(File.expand_path('../../../VERSION', __FILE__))}
      Usage: glimmer [--bundler] [--pd] [--quiet] [--debug] [--log-level=VALUE] [[ENV_VAR=VALUE]...] [[-ruby-option]...] (application.rb or task[task_args])
    
      Runs Glimmer applications and tasks.
    
      When applications are specified, they are run using Ruby,
      automatically preloading the glimmer-dsl-libui Ruby gem.
    
      Optionally, extra Glimmer options, Ruby options, and/or environment variables may be passed in.
    
      Glimmer options:
      - "--bundler=GROUP"   : Activates gems in Bundler default group in Gemfile
      - "--pd=BOOLEAN"      : Requires puts_debuggerer to enable pd method
      - "--quiet=BOOLEAN"   : Does not announce file path of Glimmer application being launched
      - "--debug"           : Displays extra debugging information and enables debug logging
      - "--log-level=VALUE" : Sets Glimmer's Ruby logger level ("ERROR" / "WARN" / "INFO" / "DEBUG"; default is none)
    
      Tasks are run via rake. Some tasks take arguments in square brackets (surround with double-quotes if using Zsh).
    
      Available tasks are below (if you do not see any, please add `require 'glimmer/rake_task'` to Rakefile and rerun or run rake -T):
      
    MULTI_LINE_STRING

    GLIMMER_LIB_GEM = 'glimmer-dsl-libui'
    GLIMMER_LIB_LOCAL = File.expand_path(File.join('lib', "#{GLIMMER_LIB_GEM}.rb"))
    GLIMMER_OPTIONS = %w[--log-level --quiet --bundler --pd]
    GLIMMER_OPTION_ENV_VAR_MAPPING = {
      '--log-level' => 'GLIMMER_LOGGER_LEVEL'   ,
      '--bundler'   => 'GLIMMER_BUNDLER_SETUP'  ,
      '--pd'        => 'PD'  ,
    }
    REGEX_RAKE_TASK_WITH_ARGS = /^([^\[]+)\[?([^\]]*)\]?$/

    class << self
      def is_arm64?
        host_cpu = OS.host_cpu.downcase
        host_cpu.include?('aarch64') || host_cpu.include?('arm')
      end
      
      def glimmer_lib
        unless @glimmer_lib
          @glimmer_lib = GLIMMER_LIB_GEM
          if File.exist?(GLIMMER_LIB_LOCAL)
            @glimmer_lib = GLIMMER_LIB_LOCAL
            puts "[DEVELOPMENT MODE] (detected #{@glimmer_lib})"
          end
        end
        @glimmer_lib
      end
      
      def dev_mode?
        glimmer_lib == GLIMMER_LIB_LOCAL
      end

      def glimmer_option_env_vars(glimmer_options)
        GLIMMER_OPTION_ENV_VAR_MAPPING.reduce({}) do |hash, pair|
          glimmer_options[pair.first] ? hash.merge(GLIMMER_OPTION_ENV_VAR_MAPPING[pair.first] => glimmer_options[pair.first]) : hash
        end
      end

      def load_env_vars(env_vars)
        env_vars.each do |key, value|
          ENV[key] = value
        end
      end

      def launch(application, ruby_options: [], env_vars: {}, glimmer_options: {})
        ruby_options_string = ruby_options.join(' ') + ' ' if ruby_options.any?
        env_vars = env_vars.merge(glimmer_option_env_vars(glimmer_options))
        load_env_vars(env_vars)
        the_glimmer_lib = glimmer_lib
        require 'puts_debuggerer' if (ENV['PD'] || ENV['pd']).to_s.downcase == 'true' || the_glimmer_lib == GLIMMER_LIB_LOCAL
        is_rake_task = !application.end_with?('.rb')
        rake_tasks = []
        if is_rake_task
          load File.expand_path('./Rakefile') if File.exist?(File.expand_path('./Rakefile')) && caller.join("\n").include?('/bin/glimmer:')
          require_relative 'rake_task'
          rake_tasks = Rake.application.tasks.map(&:to_s).map {|t| t.sub('glimmer:', '')}
           
          potential_rake_task_parts = application.match(REGEX_RAKE_TASK_WITH_ARGS)
          application = potential_rake_task_parts[1]
          rake_task_args = potential_rake_task_parts[2].split(',')
        end
        if rake_tasks.include?(application)
          rake_task = "glimmer:#{application}"
          puts "Running Glimmer rake task: #{rake_task}" if ruby_options_string.to_s.include?('--debug')
          Rake::Task[rake_task].invoke(*rake_task_args)
        else
          puts "Launching Glimmer Application: #{application}" if ruby_options_string.to_s.include?('--debug') || glimmer_options['--quiet'].to_s.downcase != 'true'
          require the_glimmer_lib
          load File.expand_path(application)
        end
      end
    end
    
    attr_reader :application_paths
    attr_reader :env_vars
    attr_reader :glimmer_options
    attr_reader :ruby_options

    def initialize(raw_options)
      raw_options << '--quiet' if !caller.join("\n").include?('/bin/glimmer:') && !raw_options.join.include?('--quiet=')
      raw_options << '--log-level=DEBUG' if raw_options.join.include?('--debug') && !raw_options.join.include?('--log-level=')
      @application_path = extract_application_path(raw_options)
      @env_vars = extract_env_vars(raw_options)
      @glimmer_options = extract_glimmer_options(raw_options)
      @ruby_options = raw_options
    end

    def launch
      if @application_path.nil?
        display_usage
      else
        launch_application
      end
    end

    private

    def launch_application
      self.class.launch(
        @application_path,
        ruby_options: @ruby_options,
        env_vars: @env_vars,
        glimmer_options: @glimmer_options
      )
    end

    def display_usage
      puts TEXT_USAGE
      display_tasks
    end
    
    def display_tasks
      if OS.windows? || Launcher.is_arm64?
        require 'rake'
        Rake::TaskManager.record_task_metadata = true
        require_relative 'rake_task'
        tasks = Rake.application.tasks
        task_lines = tasks.reject do |task|
          task.comment.nil?
        end.map do |task|
          max_task_size = tasks.map(&:name_with_args).map(&:size).max + 1
          task_name = task.name_with_args.sub('glimmer:', '')
          line = "glimmer #{task_name.ljust(max_task_size)} # #{task.comment}"
        end
        puts task_lines.to_a
      else
        require 'rake-tui'
        require 'tty-screen'
        require_relative 'rake_task'
        Rake::TUI.run(branding_header: nil, prompt_question: 'Select a Glimmer task to run:') do |task, tasks|
          max_task_size = tasks.map(&:name_with_args).map(&:size).max + 1
          task_name = task.name_with_args.sub('glimmer:', '')
          line = "glimmer #{task_name.ljust(max_task_size)} # #{task.comment}"
          bound = TTY::Screen.width - 6
          line.size <= bound ? line : "#{line[0..(bound - 3)]}..."
        end
      end
    end

    # Extract application path (which can also be a rake task, basically a non-arg)
    def extract_application_path(options)
      application_path = options.detect do |option|
        !option.start_with?('-') && !option.include?('=')
      end.tap do
        options.delete(application_path)
      end
    end

    def extract_env_vars(options)
      options.select do |option|
        !option.start_with?('-') && option.include?('=')
      end.each do |env_var|
        options.delete(env_var)
      end.reduce({}) do |hash, env_var_string|
        match = env_var_string.match(/^([^=]+)=(.+)$/)
        hash.merge(match[1] => match[2])
      end
    end

    def extract_glimmer_options(options)
      options.select do |option|
        GLIMMER_OPTIONS.reduce(false) do |result, glimmer_option|
          result || option.include?(glimmer_option)
        end
      end.each do |glimmer_option|
        options.delete(glimmer_option)
      end.reduce({}) do |hash, glimmer_option_string|
        match = glimmer_option_string.match(/^([^=]+)=?(.+)?$/)
        hash.merge(match[1] => (match[2] || 'true'))
      end
    end
  end
end
