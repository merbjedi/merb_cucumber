require 'rubygems'
require 'rake/gempackagetask'

require 'merb-core'
require 'merb-core/tasks/merb'

GEM_NAME = "merb_cucumber"
GEM_VERSION = "0.6"
AUTHOR = ["Roman Gonzalez", "David Leal", "Jacques Crocker"]
EMAIL = ["merbjedi@gmail.com"]
HOMEPAGE = "http://github.com/merbjedi/merb_cucumber"
SUMMARY = "Cucumber integration for Merb"

spec = Gem::Specification.new do |s|
  s.rubyforge_project = 'merb'
  s.name = GEM_NAME
  s.version = GEM_VERSION
  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true
  s.extra_rdoc_files = ["README.textile", "LICENSE", 'TODO']
  s.summary = SUMMARY
  s.description = s.summary
  s.authors = AUTHOR
  s.email = EMAIL
  s.homepage = HOMEPAGE
  s.add_dependency('merb-core', '>= 1.1')
  s.add_dependency('cucumber', '>= 0.4.0')
  s.require_path = 'lib'
  s.files = %w(LICENSE README.textile Rakefile TODO Generators) + Dir.glob("{lib,spec}/**/*")
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

desc "install the plugin as a gem"
task :install do
  Merb::RakeHelper.install(GEM_NAME, :version => GEM_VERSION)
end

desc "Uninstall the gem"
task :uninstall do
  Merb::RakeHelper.uninstall(GEM_NAME, :version => GEM_VERSION)
end

desc "Create a gemspec file"
task :gemspec do
  File.open("#{GEM_NAME}.gemspec", "w") do |file|
    file.puts spec.to_ruby
  end
end

require 'spec/rake/spectask'
require 'spec/rake/spectask'
require 'merb-core/test/tasks/spectasks'
