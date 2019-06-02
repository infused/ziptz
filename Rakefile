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
  sh 'irb -rubygems -I lib -r ziptz.rb'
end

desc 'Create ziptz db from zipcodes database'
task :create_ziptz do
  require 'yaml'
  require 'active_record'
  require 'tty-spinner'

  spinner = TTY::Spinner.new('[:spinner] Retrieving zip codes from database')
  spinner.auto_spin

  db_config = YAML.safe_load(File.open('database.yml'))
  ActiveRecord::Base.establish_connection(db_config)

  class ZipCode < ActiveRecord::Base
    self.table_name = 'ZIPCodes'
    self.primary_key = 'ZipCode'

    alias_attribute :zip_code, :ZipCode
    alias_attribute :time_zone, :TimeZone
    alias_attribute :day_light_saving, :DayLightSaving
  end

  data = {}
  ZipCode.find_each do |zip|
    next if zip.time_zone.blank? || zip.day_light_saving.blank?

    data[zip.zip_code] ||= {}
    data[zip.zip_code][:tz] ||= zip.time_zone
    data[zip.zip_code][:dst] ||= zip.day_light_saving
  end
  spinner = TTY::Spinner.new("[:spinner] Retrieving zip codes from database (#{data.size} records)")
  spinner.success

  spinner = TTY::Spinner.new('[:spinner] Writing tz.data')
  spinner.auto_spin
  lines = data.map { |k, v| "#{k}=#{v[:tz]}" }
  lines.sort!
  File.open('data/tz.data', 'w') do |f|
    lines.each { |line| f.puts line }
  end
  spinner = TTY::Spinner.new "[:spinner] Writing tz.data (#{File.size('data/tz.data').to_s} bytes)"
  spinner.success
  # puts File.size('data/tz.data').to_s

  spinner = TTY::Spinner.new('[:spinner] Writing dst.data')
  spinner.auto_spin
  lines = data.map { |k, v| "#{k}=#{v[:dst] =~ /y/i ? 1 : 0}" }
  lines.sort!

  File.open('data/dst.data', 'w') do |f|
    lines.each { |line| f.puts line }
  end
  spinner = TTY::Spinner.new "[:spinner] Writing dst.data (#{File.size('data/dst.data').to_s} bytes)"
  spinner.success
rescue StandardError
  spinner && spinner.error
  raise
end
