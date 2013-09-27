# Wear coveralls.
require 'coveralls'
Coveralls.wear!
# Include the ceely lib directory in the load path
$: <<  File.dirname(__FILE__)+'/../lib'
require 'yaml'
require 'pry'
require 'ceely'
# Load up the living specs
module Ceely
  module LivingSpec
    # Get the living specs
    Dir.glob(File.dirname(__FILE__)+'/../living_specs/*.yml').each do |fixtures_file|
      attribute = File.basename(fixtures_file, ".yml")
      define_method(attribute.to_sym) {
        eval "@#{attribute}_fixtures ||= YAML.load_file('#{fixtures_file}')"
      }
    end
  end
end

# Specify expect syntax per:
# http://betterspecs.org/#expect
RSpec.configure do |config|
  config.extend Ceely::LivingSpec
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

    