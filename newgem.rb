#!/usr/bin/env ruby
# frozen_string_literal: true

begin
  require "thor"
  require "bundler"
  require "pry-byebug"
rescue LoadError
  require "bundler/inline"

  gemfile do
    source "https://rubygems.org"
    gem "thor"
    gem "pry-byebug"
  end

  require "thor"
end

class Newgem < Thor::Group
  include Thor::Actions

  COPY_FILES = %w(
    .gem_release.yml
    .gitignore
    .mdlrc
    .rspec
    .rubocop-md.yml
    .rubocop.yml
    lefthook.yml
    CHANGELOG.md
    Gemfile
    LICENSE.txt
    Rakefile
    README.md
    RELEASING.md
  ).freeze

  COPY_DIRS = %w(
    .github
    spec
  ).freeze

  argument :name

  def self.source_root
    ENV.fetch("TEMPLATE", File.join(__dir__, "templates", "newgem"))
  end

  def self.exit_on_failure?
    true
  end

  def copy_files
    COPY_FILES.each { |file| template file }

    remove_file "lefthook.yml" unless docslint?
  end

  def copy_dirs
    COPY_DIRS.each { |dir| directory(dir) }

    remove_file ".github/workflows/docs-lint.yml" unless docslint?
    remove_file ".github/workflows/rspec-jruby.yml" unless jruby?
  end

  def copy_gemfiles
    template "gemfiles/rubocop.gemfile"
    return unless rails?

    template "gemfiles/jruby.gemfile" if jruby?

    template "gemfiles/rails5.gemfile"
    template "gemfiles/rails6.gemfile"
    template "gemfiles/railsmaster.gemfile"
  end

  def copy_lib
    template "lib/name.rb", "lib/#{name}.rb"
    directory "lib/dir", "lib/#{name_path}"
    remove_file "lib/#{name_path}/railtie.rb" unless rails?
  end

  def copy_gemspec
    template "newgem.gemspec", "#{name}.gemspec"
  end

  def create_makefile
    template "Makefile", "Makefile"
  end

  private

  def rails?
    return @rails if instance_variable_defined?(:@rails)

    @rails = yes?("Need Rails stuff?")
  end

  def ruby_next?
    return @ruby_next if instance_variable_defined?(:@ruby_next)

    @ruby_next = yes?("Use Ruby Next transpiler?")
  end

  def jruby?
    return @jruby if instance_variable_defined?(:@jruby)

    @jruby = yes?("Need JRuby stuff?")
  end

  def docslint?
    return @docslint if instance_variable_defined?(:@docslint)

    @docslint = yes?("Need docs lint stuff?")
  end

  def module_name
    @module_name ||= name.split("-").map do |mod|
      mod.split("_").map(&:capitalize).join
    end.join("::")
  end

  def human_name
    @human_name ||= name.split(/[-_]/).map(&:capitalize).join(" ")
  end

  def name_path
    @name_path ||= name.gsub("-", "/")
  end
end

generator = Newgem.new ARGV
generator.destination_root = ARGV[0]
generator.invoke_all
