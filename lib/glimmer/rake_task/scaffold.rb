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

require 'fileutils'
require 'os'
require 'facets'

# TODO refactor to nest under RakeTask namespace

MAIN_OBJECT = self

module Glimmer
  module RakeTask
    class Scaffold
      class << self
        include FileUtils
    
        VERSION = File.read(File.expand_path('../../../../VERSION', __FILE__)).strip
        RUBY_VERSION = File.read(File.expand_path('../../../../RUBY_VERSION', __FILE__)).strip
    
        # TODO externalize all constants into scaffold/files
    
        GITIGNORE = <<~MULTI_LINE_STRING
          *.gem
          *.rbc
          /.config
          /.mvn/
          /coverage/
          /InstalledFiles
          /pkg/
          /spec/reports/
          /spec/examples.txt
          /test/tmp/
          /test/version_tmp/
          /tmp/
          
          # Used by dotenv library to load environment variables.
          # .env
          
          ## Specific to RubyMotion:
          .dat*
          .repl_history
          build/
          *.bridgesupport
          build-iPhoneOS/
          build-iPhoneSimulator/
          
          ## Specific to RubyMotion (use of CocoaPods):
          #
          # We recommend against adding the Pods directory to your .gitignore. However
          # you should judge for yourself, the pros and cons are mentioned at:
          # https://guides.cocoapods.org/using/using-cocoapods.html#should-i-check-the-pods-directory-into-source-control
          #
          # vendor/Pods/
          
          ## Documentation cache and generated files:
          /.yardoc/
          /_yardoc/
          /doc/
          /rdoc/
          
          ## Environment normalization:
          /.bundle/
          /vendor/bundle
          /lib/bundler/man/
          
          # for a library or gem, you might want to ignore these files since the code is
          # intended to run in multiple environments; otherwise, check them in:
          # Gemfile.lock
          # .ruby-version
          # .ruby-gemset
          
          # unless supporting rvm < 1.11.0 or doing something fancy, ignore this:
          .rvmrc
          
          # Mac
          .DS_Store
          
          # Gladiator (Glimmer Editor)
          .gladiator
          .gladiator-scratchpad
          
          # Glimmer
          /dist/
          /packages/
        MULTI_LINE_STRING
    
        GEMFILE_PREFIX = <<~MULTI_LINE_STRING
          # frozen_string_literal: true
          
          source 'https://rubygems.org'
          
          git_source(:github) {|repo_name| "https://github.com/\#{repo_name}" }
        MULTI_LINE_STRING
        GEMFILE_APP_MIDFIX = <<~MULTI_LINE_STRING
        
          gem 'glimmer-dsl-libui', '~> #{VERSION}'
        MULTI_LINE_STRING
        GEMFILE_GEM_MIDFIX = <<~MULTI_LINE_STRING
        
          gem 'glimmer-dsl-libui', '~> #{VERSION.split('.')[0...2].join('.')}'
        MULTI_LINE_STRING
        GEMFILE_SUFFIX = <<~MULTI_LINE_STRING
        
          group :development do
            gem 'rspec', '~> 3.5.0'
            gem 'juwelier', '2.4.9'
            gem 'simplecov', '>= 0'
          end
        MULTI_LINE_STRING
        APP_GEMFILE = GEMFILE_PREFIX + GEMFILE_APP_MIDFIX + GEMFILE_SUFFIX
        GEM_GEMFILE = GEMFILE_PREFIX + GEMFILE_GEM_MIDFIX + GEMFILE_SUFFIX
    
        def app(app_name)
          common_app(app_name)
        end
        
        def common_app(app_name, window_type = :app, window_options = {})
          gem_name = file_name(app_name)
          gem_summary = human_name(app_name)
          return puts("The directory '#{gem_name}' already exists. Please either remove or pick a different name.") if Dir.exist?(gem_name)
#           system "ruby -S gem install bundler --no-document" if OS.windows? # resolves freezing issue with warbler and bundler 2.2.29 included in JRuby
          system "ruby -S gem install juwelier -v2.4.9 --no-document" unless juwelier_exist?
          system "ruby -S juwelier --markdown --rspec --summary '#{gem_summary}' --description '#{gem_summary}' #{gem_name}"
          return puts('Your Git user.name and/or github.user are missing! Please add in for Juwelier to help Glimmer with Scaffolding.') if `git config --get github.user`.strip.empty? || `git config --get user.name`.strip.empty?
          cd gem_name
          rm_rf 'lib'
          write '.gitignore', GITIGNORE
          write '.ruby-version', RUBY_VERSION
          write '.ruby-gemset', app_name
          write 'VERSION', '1.0.0'
          write 'LICENSE.txt', "Copyright (c) #{Time.now.year} #{app_name}"
          write 'Gemfile', gemfile(window_type)
          write 'Rakefile', gem_rakefile(app_name, nil, gem_name)
          mkdir 'app'
          write "app/#{file_name(app_name)}.rb", app_main_file(app_name)
          mkdir_p "app/#{file_name(app_name)}/model"
          mkdir_p "app/#{file_name(app_name)}/view"
          custom_window(class_name(app_name), current_dir_name, window_type, custom_window_class_name: 'Application')
          application_model(current_dir_name)
            
          mkdir_p 'icons/windows'
          icon_file = "icons/windows/#{human_name(app_name)}.ico"
          cp File.expand_path('../../../../icons/scaffold_app.ico', __FILE__), icon_file
          puts "Created #{current_dir_name}/#{icon_file}"
          
          mkdir_p 'icons/macosx'
          icon_file = "icons/macosx/#{human_name(app_name)}.icns"
          cp File.expand_path('../../../../icons/scaffold_app.icns', __FILE__), icon_file
          puts "Created #{current_dir_name}/#{icon_file}"
        
          mkdir_p 'icons/linux'
          icon_file = "icons/linux/#{human_name(app_name)}.png"
          cp File.expand_path('../../../../icons/scaffold_app.png', __FILE__), icon_file
          puts "Created #{current_dir_name}/#{icon_file}"
          
          mkdir_p "app/#{file_name(app_name)}"
          write "app/#{file_name(app_name)}/launch.rb", app_launch_file(app_name)
          mkdir_p 'bin'
          write "bin/#{file_name(app_name)}", app_bin_command_file(app_name)
          FileUtils.chmod 0755, "bin/#{file_name(app_name)}"
          if OS.windows?
            system "bundle"
            system "rspec --init"
          else
            system "bash -c '#{RVM_FUNCTION}\n cd .\n bundle\n rspec --init\n'"
          end
          write 'spec/spec_helper.rb', spec_helper_file
          if OS.mac? || OS.linux?
            system "bash -c '#{RVM_FUNCTION}\n cd .\n glimmer run\n'"
          else
            system "glimmer run"
          end
        end
    
        def custom_window(custom_window_name, namespace, window_type = nil, window_options = {})
          namespace ||= current_dir_name
          root_dir = File.exist?('app') ? 'app' : 'lib'
          parent_dir = "#{root_dir}/#{file_name(namespace)}/view"
          return puts("The file '#{parent_dir}/#{file_name(custom_window_name)}.rb' already exists. Please either remove or pick a different name.") if File.exist?("#{parent_dir}/#{file_name(custom_window_name)}.rb")
          mkdir_p parent_dir unless File.exist?(parent_dir)
          write "#{parent_dir}/#{file_name(custom_window_name)}.rb", custom_window_file(custom_window_name, namespace, window_type, window_options)
        end
    
        def custom_control(custom_control_name, namespace)
          namespace ||= current_dir_name
          root_dir = File.exist?('app') ? 'app' : 'lib'
          parent_dir = "#{root_dir}/#{file_name(namespace)}/view"
          return puts("The file '#{parent_dir}/#{file_name(custom_control_name)}.rb' already exists. Please either remove or pick a different name.") if File.exist?("#{parent_dir}/#{file_name(custom_control_name)}.rb")
          mkdir_p parent_dir unless File.exist?(parent_dir)
          write "#{parent_dir}/#{file_name(custom_control_name)}.rb", custom_control_file(custom_control_name, namespace)
        end
    
        def custom_shape(custom_shape_name, namespace)
          namespace ||= current_dir_name
          root_dir = File.exist?('app') ? 'app' : 'lib'
          parent_dir = "#{root_dir}/#{file_name(namespace)}/view"
          return puts("The file '#{parent_dir}/#{file_name(custom_shape_name)}.rb' already exists. Please either remove or pick a different name.") if File.exist?("#{parent_dir}/#{file_name(custom_shape_name)}.rb")
          mkdir_p parent_dir unless File.exist?(parent_dir)
          write "#{parent_dir}/#{file_name(custom_shape_name)}.rb", custom_shape_file(custom_shape_name, namespace)
        end
    
        def custom_window_gem(custom_window_name, namespace)
          gem_name = "glimmer-cs-#{compact_name(custom_window_name)}"
          gem_summary = "#{human_name(custom_window_name)} - Glimmer Custom Window"
          begin
            custom_window_keyword = dsl_control_name(custom_window_name)
            MAIN_OBJECT.method(custom_window_keyword)
            return puts("CustomWindow keyword `#{custom_window_keyword}` is unavailable (occupied by a built-in Ruby method)! Please pick a different name.")
          rescue NameError
            # No Op (keyword is not taken by a built in Ruby method)
          end
          if namespace
            gem_name += "-#{compact_name(namespace)}"
            gem_summary += " (#{human_name(namespace)})"
          else
            return puts('Namespace is required! Usage: glimmer scaffold:gem:customwindow[name,namespace]') unless `git config --get github.user`.to_s.strip == 'AndyObtiva'
            namespace = 'glimmer'
          end
          return puts("The directory '#{gem_name}' already exists. Please either remove or pick a different name.") if Dir.exist?(gem_name)
#           system "ruby -S gem install bundler --no-document" if OS.windows? # resolves freezing issue with warbler and bundler 2.2.29 included in JRuby
          system "ruby -S gem install juwelier -v2.4.9 --no-document" unless juwelier_exist?
          system "ruby -S juwelier --markdown --rspec --summary '#{gem_summary}' --description '#{gem_summary}' #{gem_name}"
          return puts('Your Git user.name and/or github.user are missing! Please add in for Juwelier to help Glimmer with Scaffolding.') if `git config --get github.user`.strip.empty? && `git config --get user.name`.strip.empty?
          cd gem_name
          write '.gitignore', GITIGNORE
          write '.ruby-version', RUBY_VERSION
          write '.ruby-gemset', gem_name
          write 'VERSION', '1.0.0'
          write 'Gemfile', GEM_GEMFILE
          write 'Rakefile', gem_rakefile(custom_window_name, namespace, gem_name)
          append "lib/#{gem_name}.rb", gem_main_file(custom_window_name, namespace)
          custom_window(custom_window_name, namespace, :gem)
          
          mkdir_p "lib/#{gem_name}"
          write "lib/#{gem_name}/launch.rb", gem_launch_file(gem_name, custom_window_name, namespace)
          mkdir_p 'bin'
          write "bin/#{file_name(custom_window_name)}", app_bin_command_file(gem_name, custom_window_name, namespace)
          FileUtils.chmod 0755, "bin/#{file_name(custom_window_name)}"
          if OS.windows?
            system "bundle"
            system "rspec --init"
          else
            system "bash -c '#{RVM_FUNCTION}\n cd .\n bundle\n rspec --init\n'"
          end
          write 'spec/spec_helper.rb', spec_helper_file
    
          mkdir_p 'icons/windows'
          icon_file = "icons/windows/#{human_name(gem_name)}.ico"
          cp File.expand_path('../../../../icons/scaffold_app.ico', __FILE__), icon_file
          puts "Created #{current_dir_name}/#{icon_file}"
            
          mkdir_p 'icons/macosx'
          icon_file = "icons/macosx/#{human_name(gem_name)}.icns"
          cp File.expand_path('../../../../icons/scaffold_app.icns', __FILE__), icon_file
          puts "Created #{current_dir_name}/#{icon_file}"
          
          mkdir_p 'icons/linux'
          icon_file = "icons/linux/#{human_name(gem_name)}.png"
          cp File.expand_path('../../../../icons/scaffold_app.png', __FILE__), icon_file
          puts "Created #{current_dir_name}/#{icon_file}"
          
          if OS.mac? || OS.linux?
            system "bash -c '#{RVM_FUNCTION}\n cd .\n glimmer run\n'"
          else
            system "glimmer run"
          end
          puts "Finished creating #{gem_name} Ruby gem."
          puts 'Edit Rakefile to configure gem details.'
          puts 'Run `rake` to execute specs.'
          puts 'Run `rake build` to build gem.'
          puts 'Run `rake release` to release into rubygems.org once ready.'
        end
    
        def custom_control_gem(custom_control_name, namespace)
          gem_name = "glimmer-cw-#{compact_name(custom_control_name)}"
          gem_summary = "#{human_name(custom_control_name)} - Glimmer Custom Control"
          if namespace
            gem_name += "-#{compact_name(namespace)}"
            gem_summary += " (#{human_name(namespace)})"
          else
            return puts('Namespace is required! Usage: glimmer scaffold:custom_control_gem[custom_control_name,namespace]') unless `git config --get github.user`.to_s.strip == 'AndyObtiva'
            namespace = 'glimmer'
          end
          
          return puts("The directory '#{gem_name}' already exists. Please either remove or pick a different name.") if Dir.exist?(gem_name)
#           system "ruby -S gem install bundler --no-document" if OS.windows? # resolves freezing issue with warbler and bundler 2.2.29 included in JRuby
          system "ruby -S gem install juwelier -v2.4.9 --no-document" unless juwelier_exist?
          system "ruby -S juwelier --markdown --rspec --summary '#{gem_summary}' --description '#{gem_summary}' #{gem_name}"
          return puts('Your Git user.name and/or github.user are missing! Please add in for Juwelier to help Glimmer with Scaffolding.') if `git config --get github.user`.strip.empty? && `git config --get user.name`.strip.empty?
          cd gem_name
          write '.gitignore', GITIGNORE
          write '.ruby-version', RUBY_VERSION
          write '.ruby-gemset', gem_name
          write 'VERSION', '1.0.0'
          write 'Gemfile', GEM_GEMFILE
          write 'Rakefile', gem_rakefile
          append "lib/#{gem_name}.rb", gem_main_file(custom_control_name, namespace)
          custom_control(custom_control_name, namespace)
          if OS.windows?
            system "bundle"
            system "rspec --init"
          else
            system "bash -c '#{RVM_FUNCTION}\n cd .\n bundle\n rspec --init\n'"
          end
          write 'spec/spec_helper.rb', spec_helper_file
          puts "Finished creating #{gem_name} Ruby gem."
          puts 'Edit Rakefile to configure gem details.'
          puts 'Run `rake` to execute specs.'
          puts 'Run `rake build` to build gem.'
          puts 'Run `rake release` to release into rubygems.org once ready.'
        end
    
        def custom_shape_gem(custom_shape_name, namespace)
          gem_name = "glimmer-cp-#{compact_name(custom_shape_name)}"
          gem_summary = "#{human_name(custom_shape_name)} - Glimmer Custom Shape"
          if namespace
            gem_name += "-#{compact_name(namespace)}"
            gem_summary += " (#{human_name(namespace)})"
          else
            return puts('Namespace is required! Usage: glimmer scaffold:custom_shape_gem[custom_shape_name,namespace]') unless `git config --get github.user`.to_s.strip == 'AndyObtiva'
            namespace = 'glimmer'
          end
          
          return puts("The directory '#{gem_name}' already exists. Please either remove or pick a different name.") if Dir.exist?(gem_name)
#           system "ruby -S gem install bundler --no-document" if OS.windows? # resolves freezing issue with warbler and bundler 2.2.29 included in JRuby
          system "ruby -S gem install juwelier -v2.4.9 --no-document" unless juwelier_exist?
          system "ruby -S juwelier --markdown --rspec --summary '#{gem_summary}' --description '#{gem_summary}' #{gem_name}"
          return puts('Your Git user.name and/or github.user are missing! Please add in for Juwelier to help Glimmer with Scaffolding.') if `git config --get github.user`.strip.empty? && `git config --get user.name`.strip.empty?
          cd gem_name
          write '.gitignore', GITIGNORE
          write '.ruby-version', RUBY_VERSION
          write '.ruby-gemset', gem_name
          write 'VERSION', '1.0.0'
          write 'Gemfile', GEM_GEMFILE
          write 'Rakefile', gem_rakefile
          append "lib/#{gem_name}.rb", gem_main_file(custom_shape_name, namespace)
          custom_shape(custom_shape_name, namespace)
          if OS.windows?
            system "bundle"
            system "rspec --init"
          else
            system "bash -c '#{RVM_FUNCTION}\n cd .\n bundle\n rspec --init\n'"
          end
          write 'spec/spec_helper.rb', spec_helper_file
          puts "Finished creating #{gem_name} Ruby gem."
          puts 'Edit Rakefile to configure gem details.'
          puts 'Run `rake` to execute specs.'
          puts 'Run `rake build` to build gem.'
          puts 'Run `rake release` to release into rubygems.org once ready.'
        end
        
        def application_model(current_dir_name)
          model_name = 'Greeting'
          namespace ||= current_dir_name
          root_dir = File.exist?('app') ? 'app' : 'lib'
          parent_dir = "#{root_dir}/#{file_name(namespace)}/model"
          return puts("The file '#{parent_dir}/#{file_name(model_name)}.rb' already exists. Please either remove or pick a different name.") if File.exist?("#{parent_dir}/#{file_name(model_name)}.rb")
          mkdir_p parent_dir unless File.exist?(parent_dir)
          write "#{parent_dir}/#{file_name(model_name)}.rb", model_file(model_name, namespace)
        end
    
        private
        
        def juwelier_exist?
          OS.windows? ? system('where juwelier') : system('which juwelier')
        end
    
        def write(file, content)
          File.write file, content
          file_path = File.expand_path(file)
          puts "Created #{current_dir_name}/#{file}"
        end
    
        def append(file, content)
          File.open(file, 'a') do |f|
            f.write(content)
          end
        end
    
        def current_dir_name
          File.basename(File.expand_path('.'))
        end
    
        def class_name(app_name)
          app_name.underscore.camelcase(:upper)
        end
    
        def file_name(app_name)
          app_name.underscore
        end
        alias dsl_control_name file_name
    
        def human_name(app_name)
          app_name.underscore.titlecase
        end
    
        def compact_name(gem_name)
          gem_name.underscore.camelcase.downcase
        end
        
        def gemfile(window_type)
          APP_GEMFILE
        end
    
        def app_main_file(app_name)
          <<~MULTI_LINE_STRING
            $LOAD_PATH.unshift(File.expand_path('..', __FILE__))
            
            begin
              require 'bundler/setup'
              Bundler.require(:default)
            rescue StandardError, Gem::LoadError
              # this runs when packaged as a gem (no bundler)
              require 'glimmer-dsl-libui'
              # add more gems if needed
            end
            
            class #{class_name(app_name)}
              include Glimmer
              
              APP_ROOT = File.expand_path('../..', __FILE__)
              VERSION = File.read(File.join(APP_ROOT, 'VERSION'))
              LICENSE = File.read(File.join(APP_ROOT, 'LICENSE.txt'))
            end
    
            require '#{file_name(app_name)}/view/#{file_name(app_name)}'
          MULTI_LINE_STRING
        end
    
        def gem_main_file(custom_control_name, namespace = nil)
          custom_control_file_path = ''
          custom_control_file_path += "#{file_name(namespace)}/" if namespace
          custom_control_file_path += "view"
          custom_control_file_path += "/#{file_name(custom_control_name)}"
    
          <<~MULTI_LINE_STRING
            $LOAD_PATH.unshift(File.expand_path('..', __FILE__))
            
            require 'glimmer-dsl-libui'
            require '#{custom_control_file_path}'
          MULTI_LINE_STRING
        end
    
        def app_launch_file(app_name)
          <<~MULTI_LINE_STRING
            require_relative '../#{file_name(app_name)}'
            
            #{class_name(app_name)}::View::#{class_name(app_name)}.launch
          MULTI_LINE_STRING
        end
        
        def app_bin_command_file(app_name_or_gem_name, custom_window_name=nil, namespace=nil)
          if custom_window_name.nil?
            runner = "File.expand_path('../../app/#{file_name(app_name_or_gem_name)}/launch.rb', __FILE__)"
          else
            runner = "File.expand_path('../../lib/#{app_name_or_gem_name}/launch.rb', __FILE__)"
          end
          <<~MULTI_LINE_STRING
            #!/usr/bin/env ruby
            
            runner = #{runner}
            
            require 'glimmer/launcher'
            
            launcher = Glimmer::Launcher.new([runner] + ARGV)
            launcher.launch
          MULTI_LINE_STRING
        end
        
        def gem_launch_file(gem_name, custom_window_name, namespace)
          # TODO change this so that it does not mix Glimmer unto the main object
          <<~MULTI_LINE_STRING
            require_relative '../#{gem_name}'
            
            #{class_name(namespace)}::View::#{class_name(custom_window_name)}.launch
          MULTI_LINE_STRING
        end
    
        def gem_rakefile(custom_window_name = nil, namespace = nil, gem_name = nil)
          rakefile_content = File.read('Rakefile')
          lines = rakefile_content.split("\n")
          require_rake_line_index = lines.index(lines.detect {|l| l.include?("require 'rake'") })
          lines.insert(require_rake_line_index, "require 'glimmer/launcher'")
          gem_files_line_index = lines.index(lines.detect {|l| l.include?('# dependencies defined in Gemfile') })
          if custom_window_name
            lines.insert(gem_files_line_index, "  gem.files = Dir['VERSION', 'LICENSE.txt', 'app/**/*', 'bin/**/*', 'config/**/*', 'db/**/*', 'docs/**/*', 'fonts/**/*', 'icons/**/*', 'images/**/*', 'lib/**/*', 'script/**/*', 'sounds/**/*', 'videos/**/*']")
            lines.insert(gem_files_line_index+1, "  gem.require_paths = ['lib', 'app']")
            lines.insert(gem_files_line_index+2, "  gem.executables = ['#{file_name(custom_window_name)}']") if custom_window_name
          else
            lines.insert(gem_files_line_index, "  gem.files = Dir['VERSION', 'LICENSE.txt', 'lib/**/*']")
          end
          lines << "\nrequire 'glimmer/rake_task'\n"
          lines.join("\n")
        end
    
        def spec_helper_file
          content = File.read('spec/spec_helper.rb')
          lines = content.split("\n")
          require_line_index = lines.index(lines.detect {|l| l.include?('RSpec.configure do') })
          lines[require_line_index...require_line_index] = [
            "require 'bundler/setup'",
            'Bundler.require(:default, :development)',
          ]
          configure_block_line_index = lines.index(lines.detect {|l| l.include?('RSpec.configure do') }) + 1
          lines[configure_block_line_index...configure_block_line_index] = [
            '  # The following ensures rspec tests that instantiate and set Glimmer DSL controls in @target get cleaned after',
            '  config.after do',
            '    @target.dispose if @target && @target.respond_to?(:dispose)',
            '    Glimmer::DSL::Engine.reset',
            '  end',
          ]
          
          lines << "\nrequire 'glimmer/rake_task'\n"
          lines.join("\n")
        end
    
        def custom_window_file(custom_window_name, namespace, window_type, window_options = {})
          window_options ||= {}
          window_options[:custom_window_class_name] ||= 'CustomWindow'
          namespace_type = class_name(namespace) == class_name(current_dir_name) ? 'class' : 'module'
    
          custom_window_file_content = ''
          
          if %i[gem app].include?(window_type)
            custom_window_file_content += <<-MULTI_LINE_STRING
require '#{current_dir_name}/model/greeting'

            MULTI_LINE_STRING
          end
    
          custom_window_file_content += <<-MULTI_LINE_STRING
#{namespace_type} #{class_name(namespace)}
  module View
    class #{class_name(custom_window_name)}
      include Glimmer::LibUI::#{window_options[:custom_window_class_name]}
    
          MULTI_LINE_STRING
          
          if window_type == :gem
            custom_window_file_content += <<-MULTI_LINE_STRING
      APP_ROOT = File.expand_path('../../../..', __FILE__)
      VERSION = File.read(File.join(APP_ROOT, 'VERSION'))
      LICENSE = File.read(File.join(APP_ROOT, 'LICENSE.txt'))
            MULTI_LINE_STRING
          end
          
          custom_window_file_content += <<-MULTI_LINE_STRING
          
      ## Add options like the following to configure CustomWindow by outside consumers
      #
      # options :title, :background_color
      # option :width, default: 320
      # option :height, default: 240
          MULTI_LINE_STRING
      
          custom_window_file_content += <<-MULTI_LINE_STRING
  
      ## Use before_body block to pre-initialize variables to use in body and
      #  to setup application menu
      #
          MULTI_LINE_STRING
          
          if %i[gem app].include?(window_type)
            custom_window_file_content += <<-MULTI_LINE_STRING
      before_body do
        @greeting = Model::Greeting.new
        
        menu('File') {
          menu_item('Preferences...') {
            on_clicked do
              display_preferences_dialog
            end
          }
          
          # Enables quitting with CMD+Q on Mac with Mac Quit menu item
          quit_menu_item if OS.mac?
        }
        menu('Help') {
          if OS.mac?
            about_menu_item {
              on_clicked do
                display_about_dialog
              end
            }
          end
          
          menu_item('About') {
            on_clicked do
              display_about_dialog
            end
          }
        }
      end
            MULTI_LINE_STRING
          else
            custom_window_file_content += <<-MULTI_LINE_STRING
      # before_body do
      #
      # end
            MULTI_LINE_STRING
          end
    
          custom_window_file_content += <<-MULTI_LINE_STRING
  
      ## Use after_body block to setup observers for controls in body
      #
      # after_body do
      #
      # end
  
      ## Add control content inside custom window body
      ## Top-most control must be a window or another custom window
      #
      body {
        window {
          # Replace example content below with custom window content
          content_size 240, 240
          title '#{human_name(namespace)}'
          
          margined true
          
          label {
            #{%i[gem app].include?(window_type) ? "text <= [@greeting, :text]" : "text '#{human_name(custom_window_name)}'"}
          }
        }
      }
            MULTI_LINE_STRING
          
          if %i[gem app].include?(window_type)
            custom_window_file_content += <<-MULTI_LINE_STRING
  
      def display_about_dialog
        message = "#{human_name(namespace)}#{" - #{human_name(custom_window_name)}" if window_type == :gem} \#{VERSION}\\n\\n\#{LICENSE}"
        msg_box('About', message)
      end
      
            MULTI_LINE_STRING
          end
          
          if %i[gem app].include?(window_type)
            custom_window_file_content += <<-MULTI_LINE_STRING
      def display_preferences_dialog
        window {
          title 'Preferences'
          content_size 200, 100
          
          margined true
          
          vertical_box {
            padded true
            
            label('Greeting:') {
              stretchy false
            }
            
            radio_buttons {
              stretchy false
              
              items Model::Greeting::GREETINGS
              selected <=> [@greeting, :text_index]
            }
          }
        }.show
      end
            MULTI_LINE_STRING
          end
          
          custom_window_file_content += <<-MULTI_LINE_STRING
    end
  end
end
          MULTI_LINE_STRING
        end
    
        def custom_control_file(custom_control_name, namespace)
          namespace_type = class_name(namespace) == class_name(current_dir_name) ? 'class' : 'module'
    
          <<-MULTI_LINE_STRING
#{namespace_type} #{class_name(namespace)}
  module View
    class #{class_name(custom_control_name)}
      include Glimmer::LibUI::CustomControl
  
      ## Add options like the following to configure CustomControl by outside consumers
      #
      # options :custom_text, :background_color
      # option :foreground_color, default: :red
  
      ## Use before_body block to pre-initialize variables to use in body
      #
      #
      # before_body do
      #
      # end
  
      ## Use after_body block to setup observers for controls in body
      #
      # after_body do
      #
      # end
  
      ## Add control content under custom control body
      ##
      ## If you want to add a window as the top-most control,
      ## consider creating a custom window instead
      ## (Glimmer::LibUI::CustomWindow offers window convenience methods, like show and hide)
      #
      body {
        # Replace example content below with custom control content
        label {
          background :red
        }
      }
  
    end
  end
end
          MULTI_LINE_STRING
        end
        
        def custom_shape_file(custom_shape_name, namespace)
          namespace_type = class_name(namespace) == class_name(current_dir_name) ? 'class' : 'module'
    
          <<-MULTI_LINE_STRING
#{namespace_type} #{class_name(namespace)}
  module View
    class #{class_name(custom_shape_name)}
      include Glimmer::LibUI::CustomShape
  
      ## Add options like the following to configure CustomShape by outside consumers
      #
      # options :option1, option2, option3
      option :background_color, default: :red
      option :size_width, default: 100
      option :size_height, default: 100
      option :location_x, default: 0
      option :location_y, default: 0
  
      ## Use before_body block to pre-initialize variables to use in body
      #
      #
      # before_body do
      #
      # end
  
      ## Use after_body block to setup observers for shapes in body
      #
      # after_body do
      #
      # end
  
      ## Add shape content under custom shape body
      #
      body {
        # Replace example content below with custom shape content
        shape(location_x, location_y) {
          path {
            background background_color
            cubic size_width - size_width*0.66, size_height/2 - size_height*0.33, size_width*0.65 - size_width*0.66, 0 - size_height*0.33, size_width/2 - size_width*0.66, size_height*0.75 - size_height*0.33, size_width - size_width*0.66, size_height - size_height*0.33
          }
          
          path {
            background background_color
            cubic size_width - size_width*0.66, size_height/2 - size_height*0.33, size_width*1.35 - size_width*0.66, 0 - size_height*0.33, size_width*1.5 - size_width*0.66, size_height*0.75 - size_height*0.33, size_width - size_width*0.66, size_height - size_height*0.33
          }
        }
      }
  
    end
  end
end
          MULTI_LINE_STRING
        end
        
        def model_file(model_name, namespace)
          namespace_type = class_name(namespace) == class_name(current_dir_name) ? 'class' : 'module'
    
          <<-MULTI_LINE_STRING
#{namespace_type} #{class_name(namespace)}
  module Model
    class #{class_name(model_name)}
      GREETINGS = [
        'Hello, World!',
        'Howdy, Partner!'
      ]
      
      attr_accessor :text
      
      def initialize
        @text = GREETINGS.first
      end
      
      def text_index=(new_text_index)
        self.text = GREETINGS[new_text_index]
      end
      
      def text_index
        GREETINGS.index(text)
      end
    end
  end
end
          MULTI_LINE_STRING
        end
        
      end
      
    end
    
  end
  
end
