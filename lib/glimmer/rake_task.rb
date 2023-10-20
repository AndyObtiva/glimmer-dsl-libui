# Copyright (c) 2021-2023 Andy Maleh
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

module Glimmer
  module RakeTask
    RVM_FUNCTION = <<~MULTI_LINE_STRING
      # Load RVM into a shell session *as a function*
      if [[ -s "$HOME/.rvm/scripts/rvm" ]] ; then
      
        # First try to load from a user install
        source "$HOME/.rvm/scripts/rvm"
      
      elif [[ -s "/usr/local/rvm/scripts/rvm" ]] ; then
      
        # Then try to load from a root install
        source "/usr/local/rvm/scripts/rvm"
      
      fi
    MULTI_LINE_STRING
  end
end

require 'rake'
    
ENV['GLIMMER_LOGGER_ENABLED'] = 'false'
require 'puts_debuggerer' if ("#{ENV['pd']}#{ENV['PD']}").to_s.downcase.include?('true')

namespace :glimmer do
  desc 'Runs Glimmer app or custom window gem in the current directory, unless app_path is specified, then runs it instead (app_path is optional)'
  task :run, [:app_path] do |t, args|
    require_relative 'launcher'
    if args[:app_path].nil?
      require 'fileutils'
      current_directory_name = File.basename(FileUtils.pwd)
      assumed_shell_script = File.join('.', 'bin', current_directory_name)
      assumed_shell_script = Dir.glob('./bin/*').detect {|f| File.file?(f)} if !File.exist?(assumed_shell_script)
      Glimmer::Launcher.new([assumed_shell_script]).launch
    else
      Glimmer::Launcher.new([args[:app_path]]).launch
    end
  end
  
  desc 'Brings up the Glimmer Meta-Sample app to allow browsing, running, and viewing code of Glimmer samples'
  task :examples do
    Glimmer::Launcher.new([File.expand_path('../../../examples/meta_example.rb', __FILE__)]).launch
  end
  task :samples do
    Glimmer::Launcher.new([File.expand_path('../../../examples/meta_example.rb', __FILE__)]).launch
  end

  desc 'Scaffold Glimmer application directory structure to build a new app'
  task :scaffold, [:app_name] do |t, args|
    require_relative 'rake_task/scaffold'
    Glimmer::RakeTask::Scaffold.app(args[:app_name])
  end

  namespace :scaffold do
    desc 'Scaffold Glimmer::UI::CustomWindow subclass (full window view) under app/views (namespace is optional) [alt: scaffold:cw]'
    task :customwindow, [:name, :namespace] do |t, args|
      require_relative 'rake_task/scaffold'
      Glimmer::RakeTask::Scaffold.custom_window(args[:name], args[:namespace])
    end
    
    task :cw, [:name, :namespace] => :customwindow
    task :custom_window, [:name, :namespace] => :customwindow
    task :"custom-window", [:name, :namespace] => :customwindow
    
    desc 'Scaffold Glimmer::UI::CustomControl subclass (part of a view) under app/views (namespace is optional) [alt: scaffold:cc]'
    task :customcontrol, [:name, :namespace] do |t, args|
      require_relative 'rake_task/scaffold'
      Glimmer::RakeTask::Scaffold.custom_control(args[:name], args[:namespace])
    end
    
    task :cc, [:name, :namespace] => :customcontrol
    task :custom_control, [:name, :namespace] => :customcontrol
    task :"custom-control", [:name, :namespace] => :customcontrol
    
    desc 'Scaffold Glimmer::UI::CustomShape subclass (part of a view) under app/views (namespace is optional) [alt: scaffold:cs]'
    task :customshape, [:name, :namespace] do |t, args|
      require_relative 'rake_task/scaffold'
      Glimmer::RakeTask::Scaffold.custom_shape(args[:name], args[:namespace])
    end
    
    task :cs, [:name, :namespace] => :customshape
    task :custom_shape, [:name, :namespace] => :customshape
    task :"custom-shape", [:name, :namespace] => :customshape
    
    namespace :gem do
      desc 'Scaffold Glimmer::UI::CustomWindow subclass (full window view) under its own Ruby gem + app project (namespace is required) [alt: scaffold:gem:cw]'
      task :customwindow, [:name, :namespace] do |t, args|
        require_relative 'rake_task/scaffold'
        Glimmer::RakeTask::Scaffold.custom_window_gem(args[:name], args[:namespace])
      end
      
      task :cw, [:name, :namespace] => :customwindow
      task :custom_window, [:name, :namespace] => :customwindow
      task :"custom-window", [:name, :namespace] => :customwindow
      
      desc 'Scaffold Glimmer::UI::CustomControl subclass (part of a view) under its own Ruby gem project (namespace is required) [alt: scaffold:gem:cc]'
      task :customcontrol, [:name, :namespace] do |t, args|
        require_relative 'rake_task/scaffold'
        Glimmer::RakeTask::Scaffold.custom_control_gem(args[:name], args[:namespace])
      end
    
      task :cc, [:name, :namespace] => :customcontrol
      task :custom_control, [:name, :namespace] => :customcontrol
      task :"custom-control", [:name, :namespace] => :customcontrol
      
      desc 'Scaffold Glimmer::UI::CustomShape subclass (part of a view) under its own Ruby gem project (namespace is required) [alt: scaffold:gem:cs]'
      task :customshape, [:name, :namespace] do |t, args|
        require_relative 'rake_task/scaffold'
        Glimmer::RakeTask::Scaffold.custom_shape_gem(args[:name], args[:namespace])
      end
    
      task :cs, [:name, :namespace] => :customshape
      task :custom_shape, [:name, :namespace] => :customshape
      task :"custom-shape", [:name, :namespace] => :customshape
    end
    
    # legacy support
    
    task :custom_window_gem, [:name, :namespace] => 'gem:customwindow'
    task :custom_control_gem, [:name, :namespace] => 'gem:customcontrol'
    task :custom_shape_gem, [:name, :namespace] => 'gem:customshape'
    
  end
  
  namespace :list do
    task :list_require do
      require_relative 'rake_task/list'
    end
    
    namespace :gems do
      desc 'List Glimmer custom control gems available at rubygems.org (query is optional) [alt: list:gems:cc]'
      task :customcontrol, [:query] => :list_require do |t, args|
        Glimmer::RakeTask::List.custom_control_gems(args[:query])
      end
      
      task :cc, [:query] => :customcontrol
      task :custom_control, [:query] => :customcontrol
      task :"custom-control", [:query] => :customcontrol
      
      desc 'List Glimmer custom window gems available at rubygems.org (query is optional) [alt: list:gems:cw]'
      task :customwindow, [:query] => :list_require do |t, args|
        Glimmer::RakeTask::List.custom_window_gems(args[:query])
      end
      
      task :cw, [:query] => :customwindow
      task :custom_window, [:query] => :customwindow
      task :"custom-window", [:query] => :customwindow
      
      desc 'List Glimmer custom shape gems available at rubygems.org (query is optional) [alt: list:gems:cs]'
      task :customshape, [:query] => :list_require do |t, args|
        Glimmer::RakeTask::List.custom_shape_gems(args[:query])
      end
      
      task :cs, [:query] => :customshape
      task :custom_shape, [:query] => :customshape
      task :"custom-shape", [:query] => :customshape
      
      desc 'List Glimmer DSL gems available at rubygems.org (query is optional)'
      task :dsl, [:query] => :list_require do |t, args|
        Glimmer::RakeTask::List.dsl_gems(args[:query])
      end
    
    end
    
    # legacy support
    
    task :custom_window_gems, [:name, :namespace] => 'gems:customwindow'
    task :custom_control_gems, [:name, :namespace] => 'gems:customcontrol'
    
  end
end
