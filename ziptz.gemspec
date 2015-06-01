lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)
require 'ziptz/version'

Gem::Specification.new do |s|
  s.name = 'ziptz'
  s.version = ZipTZ::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ['Keith Morrison']
  s.email = 'keithm@infused.org'
  s.homepage = 'http://github.com/infused/ziptz'
  s.summary = 'TimeZone for any 5-digit US zip code'
  s.description = 'Get timezone info for all 5-digit US zip codes'
  s.license = 'MIT'

  s.rdoc_options = ['--charset=UTF-8']
  s.extra_rdoc_files = ['README.md', 'LICENSE']
  s.files = Dir['[A-Z]*', '{data,lib,spec}/**/*', 'ziptz.gemspec']
  s.test_files = Dir.glob('spec/**/*_spec.rb')
  s.require_paths = ['lib']
  s.required_ruby_version = '>= 2.0.0'
end
