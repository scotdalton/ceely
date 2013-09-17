# Wear coveralls.
require 'coveralls'
Coveralls.wear!
# Include the ceely lib directory
$: <<  File.dirname(__FILE__)+'/../lib'
require 'ceely'
# Specify expect syntax per:
# http://betterspecs.org/#expect
RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
