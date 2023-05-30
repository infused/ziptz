require File.expand_path('lib/ziptz')

Gem::Specification.new do |s|
  s.name = 'ziptz'
  s.version = Ziptz::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ['Keith Morrison']
  s.email = 'keithm@infused.org'
  s.homepage = 'http://github.com/infused/ziptz'
  s.summary = 'TimeZone info for any 5-digit US zip code'
  s.description = 'Get timezone info for all 5-digit US zip codes'
  s.license = 'MIT'

  s.rdoc_options = ['--charset=UTF-8']
  s.extra_rdoc_files = ['README.md', 'LICENSE']
  s.files = Dir['README.md', 'LICENSE', '{data,lib,spec}/**/*', 'ziptz.gemspec']
  s.test_files = Dir.glob('spec/**/*_spec.rb')
  s.require_paths = ['lib']
  s.required_ruby_version = '>= 2.0.0'
  s.metadata['rubygems_mfa_required'] = 'true'
end
