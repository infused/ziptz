require 'bundler/setup';
Bundler.setup(:default, :development)

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new :spec do |t|
  t.rspec_opts = %w(--color)
end

RSpec::Core::RakeTask.new :specdoc do |t|
  t.rspec_opts = %w(-fl)
end

task :default => :spec

desc "Open an irb session preloaded with this library"
task :console do
  sh "irb -rubygems -I lib -r ziptz.rb"
end

desc 'Create ziptz.yml from zipcodes database'
task :create_ziptz do
  require 'yaml'
  require 'active_record'

  db_config = YAML::load(File.open('database.yml'))
  ActiveRecord::Base.establish_connection(db_config)

  class ZipCode < ActiveRecord::Base
    self.table_name = 'ZIPCodes'
    self.primary_key = 'ZipCode'

    alias_attribute :zip_code, :ZipCode
    alias_attribute :time_zone, :TimeZone
  end

  puts "Retrieving zip codes from database"

  data = {}
  ZipCode.find_each do |zip|
    data[zip.zip_code] ||= zip.time_zone
  end

  puts "Writing ziptz.data"

  lines = data.map {|k, v| "#{k}=#{v}"}
  lines.sort!

  File.open('ziptz.data', 'w') do |f|
    lines.each {|line| f.puts line}
  end

end
