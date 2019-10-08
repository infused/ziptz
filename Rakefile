require 'bundler/setup'
Bundler.setup(:default, :development)

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new :spec do |t|
  t.rspec_opts = %w[--color]
end

RSpec::Core::RakeTask.new :specdoc do |t|
  t.rspec_opts = %w[-fl]
end

task default: :spec

desc 'Open an irb session preloaded with this library'
task :console do
  sh 'irb -r rubygems -I lib -r ziptz.rb'
end

desc 'Create ziptz db from zipcodes database'
task :create_ziptz do
  require 'zip_code'
  ZipCode.import
end
