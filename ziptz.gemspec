# frozen_string_literal: true

require_relative 'lib/ziptz/version'

Gem::Specification.new do |s|
  s.name = 'ziptz'
  s.version = Ziptz::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ['Keith Morrison']
  s.email = 'keithm@infused.org'
  s.homepage = 'https://github.com/infused/ziptz'
  s.summary = 'TimeZone info for any 5-digit US zip code'
  s.description = 'Get timezone info for all 5-digit US zip codes'
  s.license = 'MIT'

  s.rdoc_options = ['--charset=UTF-8']
  s.extra_rdoc_files = ['README.md', 'LICENSE']
  s.files = Dir['README.md', 'CHANGELOG.md', 'LICENSE', 'lib/**/*', 'ziptz.gemspec']
  s.require_paths = ['lib']
  s.required_ruby_version = '>= 3.3.0'
  s.metadata = {
    'source_code_uri' => 'https://github.com/infused/ziptz',
    'changelog_uri' => 'https://github.com/infused/ziptz/blob/main/CHANGELOG.md',
    'bug_tracker_uri' => 'https://github.com/infused/ziptz/issues',
    'rubygems_mfa_required' => 'true'
  }
  s.add_dependency 'sqlite3', '~> 2.0'
end
