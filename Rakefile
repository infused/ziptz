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
  require 'pry'
  require 'json'

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

  puts "Writing ziptz.yml"

  File.open('ziptz.yml', 'w') do |f|
    f.write data.to_yaml
  end


  # found = []
  #
  # data = {}
  # 0.upto(99999) do |n|
  #   s = n.to_s
  #   unless found.include?(s)
  #     zips = ZipCode.select('ZipCode, TimeZone').where(['ZipCode LIKE ?', "#{s}%"])
  #     puts "#{n}:#{zips.first.time_zone}"
  #
  #
  #
  #
  #     # if !zips.empty? && zips.all? {|zip| zip.time_zone == zips.first.time_zone}
  #     #   puts 'wha!?'
  #     #   (s.size + 1).upto(5) do |x|
  #     #     found = found + (s.ljust(x, '0')..s.ljust(x, '9')).to_a
  #     #   end
  #     #
  #     #   puts found
  #     #
  #     #   # if n == 104
  #     #   #   binding.pry
  #     #   # end
  #     #
  #     # end
  #   end
  # end

end
