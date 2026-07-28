# frozen_string_literal: true

require 'ziptz'
require 'yaml'
require 'rspec'
require 'tmpdir'
require 'fileutils'

RSpec.configure do |config|
  config.order = :random
  config.disable_monkey_patching!
end
