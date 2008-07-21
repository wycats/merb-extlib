require "rake"
require "rake/clean"
require "rake/gempackagetask"
require "rake/rdoctask"
require "rake/testtask"
require "spec/rake/spectask"
require "fileutils"

def __DIR__
  File.dirname(__FILE__)
end

include FileUtils

NAME = "merb-extlib"

require "lib/#{NAME}/version"

def sudo
  ENV['MERB_SUDO'] ||= "sudo"
  sudo = windows? ? "" : ENV['MERB_SUDO']
end

def windows?
  (PLATFORM =~ /win32|cygwin/) rescue nil
end

def install_home
  ENV['GEM_HOME'] ? "-i #{ENV['GEM_HOME']}" : ""
end

##############################################################################
# Packaging & Installation
##############################################################################
CLEAN.include ["**/.*.sw?", "pkg", "lib/*.bundle", "*.gem", "doc/rdoc", ".config", "coverage", "cache"]

desc "Run the specs."
task :default => :specs

task :merb => [:clean, :rdoc, :package]

spec = Gem::Specification.new do |s|
  s.name         = NAME
  s.version      = Merb::Extlib::VERSION
  s.platform     = Gem::Platform::RUBY
  s.author       = "Ezra Zygmuntowicz"
  s.email        = "ez@engineyard.com"
  s.homepage     = "http://merbivore.com"
  s.summary      = "Ruby core extensions library extracted from Merb."
  s.bindir       = "bin"
  s.description  = s.summary
  s.require_path = "lib"
  s.files        = %w( LICENSE Rakefile ) + Dir["{spec,lib}/**/*"]

  # rdoc
  s.has_rdoc         = true
  s.extra_rdoc_files = %w( README LICENSE )
  #s.rdoc_options     += RDOC_OPTS + ["--exclude", "^(app|uploads)"]

  # Dependencies
  s.add_dependency "rake"
  s.add_dependency "json_pure"
  s.add_dependency "rspec"
  # Requirements
  s.requirements << "install the json gem to get faster json parsing"
  s.required_ruby_version = ">= 1.8.4"
end

Rake::GemPackageTask.new(spec) do |package|
  package.gem_spec = spec
end

desc "Run :package and install the resulting .gem"
task :install => :package do
  sh %{#{sudo} gem install #{install_home} --local pkg/#{NAME}-#{Merb::Extlib::VERSION}.gem --no-rdoc --no-ri}
end

desc "Run :package and install the resulting .gem with jruby"
task :jinstall => :package do
  sh %{#{sudo} jruby -S gem install #{install_home} pkg/#{NAME}-#{Merb::Extlib::VERSION}.gem --no-rdoc --no-ri}
end

desc "Run :clean and uninstall the .gem"
task :uninstall => :clean do
  sh %{#{sudo} gem uninstall #{NAME}}
end

namespace :github do
  desc "Update Github Gemspec"
  task :update_gemspec do
    skip_fields = %w(new_platform original_platform)
    integer_fields = %w(specification_version)

    result = "Gem::Specification.new do |s|\n"
    spec.instance_variables.each do |ivar|
      value = spec.instance_variable_get(ivar)
      name  = ivar.split("@").last
      next if skip_fields.include?(name) || value.nil? || value == "" || (value.respond_to?(:empty?) && value.empty?)
      if name == "dependencies"
        value.each do |d|
          dep, *ver = d.to_s.split(" ")
          result <<  "  s.add_dependency #{dep.inspect}, #{ver.join(" ").inspect.gsub(/[()]/, "")}\n"
        end
      else
        case value
        when Array
          value =  name != "files" ? value.inspect : value.inspect.split(",").join(",\n")
        when String
          value = value.to_i if integer_fields.include?(name)
          value = value.inspect
        else
          value = value.to_s.inspect
        end
        result << "  s.#{name} = #{value}\n"
      end
    end
    result << "end"
    File.open(File.join(File.dirname(__FILE__), "#{spec.name}.gemspec"), "w"){|f| f << result}
  end
end

##############################################################################
# Documentation
##############################################################################
task :doc => [:rdoc]
namespace :doc do

  Rake::RDocTask.new do |rdoc|
    files = ["LICENSE", "CHANGELOG", "lib/**/*.rb"]
    rdoc.rdoc_files.add(files)
    rdoc.main = "README"
    rdoc.title = "Merb::Extlib docs"
    rdoc.rdoc_dir = "doc/rdoc"
    rdoc.options << "--line-numbers" << "--inline-source"
  end

  desc "rdoc to rubyforge"
  task :rubyforge do
    # sh %{rake doc}
    sh %{#{sudo} chmod -R 755 doc} unless windows?
    sh %{/usr/bin/scp -r -p doc/rdoc/* ezmobius@rubyforge.org:/var/www/gforge-projects/merb}
  end
end

##############################################################################
# rSpec & rcov
##############################################################################
desc "Run :specs, :rcov"
task :aok => [:specs, :rcov]

desc "Run all specs"
Spec::Rake::SpecTask.new("spec") do |t|
  t.spec_opts = ["--format", "specdoc", "--colour"]
  t.spec_files = Dir["spec/**/*_spec.rb"].sort
end

desc "Run coverage suite"
task :rcov do
  require 'fileutils'
  FileUtils.rm_rf("coverage") if File.directory?("coverage")
  FileUtils.mkdir("coverage")
  path = File.expand_path(Dir.pwd)
  files = Dir["spec/**/*_spec.rb"]
  files.each do |spec|
    puts "Getting coverage for #{File.expand_path(spec)}"
    command = %{rcov #{File.expand_path(spec)} --aggregate #{path}/coverage/data.data --exclude ".*" --include-file "lib/merb-core(?!\/vendor)"}
    command += " --no-html" unless spec == files.last
    `#{command} 2>&1`
  end
end

task :release => :package do
  if ENV["RELEASE"]
    sh %{rubyforge add_release merb merb "#{ENV["RELEASE"]}" pkg/#{NAME}-#{Merb::VERSION}.gem}
  else
    puts "Usage: rake release RELEASE='Clever tag line goes here'"
  end
end

##############################################################################
# SYNTAX CHECKING
##############################################################################

task :check_syntax do
  `find . -name "*.rb" |xargs -n1 ruby -c |grep -v "Syntax OK"`
  puts "* Done"
end



namespace :tools do
  namespace :tags do
    desc "Generates Emacs tags using Exuberant Ctags."
    task :emacs do
      sh "ctags -e --Ruby-kinds=-f -o TAGS -R lib"
    end
  end
end
