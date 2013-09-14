require 'factory_girl'

FactoryGirl.define do
  factory :note do
    name 'John Doe'
    date_of_birth { 21.years.ago }
  end
end