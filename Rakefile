# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'os'
require_relative 'lib/glimmer/launcher'
require 'rake'
require 'juwelier'
begin
  juwelier_required = require 'juwelier'
rescue Exception
  juwelier_required = nil
end
unless juwelier_required.nil?
  Juwelier::Tasks.new do |gem|
    # gem is a Gem::Specification... see http://guides.rubygems.org/specification-reference/ for more options
    gem.name = "glimmer-dsl-libui"
    gem.homepage = "http://github.com/AndyObtiva/glimmer-dsl-libui"
    gem.license = "MIT"
    gem.summary = %Q{Glimmer DSL for LibUI (Fukuoka Award Winning Prerequisite-Free Ruby Desktop Development Cross-Platform Native GUI Library)}
    gem.description = %Q{Glimmer DSL for LibUI (Fukuoka Award Winning Prerequisite-Free Ruby Desktop Development Cross-Platform Native GUI Library) - Winner of Fukuoka Ruby Award Competition 2022 Special Award (https://andymaleh.blogspot.com/2022/02/glimmer-dsl-for-libui-wins-fukuoka-ruby.html) - No need to pre-install any prerequisites. Just install the gem and have cross-platform native GUI that just works on Mac, Windows, and Linux! Glimmer DSL for LibUI aims to provide declarative DSL syntax that visually maps to GUI control hierarchy, convention over configuration via smart defaults, automation of low-level details, requiring the least amount of syntax possible to build GUI, bidirectional data-binding, custom control/window support, and application/gem/window/control scaffolding. If you liked Shoes, You'll love Glimmer!}
    gem.email = "andy.am@gmail.com"
    gem.authors = ["Andy Maleh"]
    gem.executables = ['glimmer', 'girb']
    gem.files = ['README.md', 'CHANGELOG.md', 'VERSION', 'RUBY_VERSION', 'LICENSE.txt', 'glimmer-dsl-libui.gemspec', 'bin/**/*', 'lib/**/*', 'icons/**/*', 'examples/**/*', 'sounds/**/*', 'docs/**/*']
    gem.require_paths = ['lib', '.']
  
    # dependencies defined in Gemfile
  end
  Juwelier::RubygemsDotOrgTasks.new
end

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

desc "Code coverage detail"
task :simplecov do
  ENV['COVERAGE'] = "true"
  Rake::Task['spec'].execute
end

task :default => :spec

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "glimmer-dsl-libui #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

Rake::Task["build"].enhance([:spec])
