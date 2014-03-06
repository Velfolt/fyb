require "bundler/gem_tasks"
require "rspec/core/rake_task"
require 'rdoc'

RSpec::Core::RakeTask.new(:spec)

RDoc::Task.new(:rdoc => "rdoc", :clobber_rdoc => "rdoc:clean", :rerdoc => "rdoc:force")

task :default => :spec
