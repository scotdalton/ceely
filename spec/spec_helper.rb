$: <<  File.dirname(__FILE__)+'/../lib'
require 'ceely'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
