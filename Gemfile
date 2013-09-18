source "https://rubygems.org"
# Gotta be JRuby
platforms :jruby do
  gem "rake", "~> 10.1.0"
  gem "require_all", "~> 1.3.1"
  gem "jsound", "~> 0.1.3"
  gem "shoes", git: "https://github.com/shoes/shoes4.git"

  group :development, :test do
    gem "ruby-debug", "~> 0.10.4"
    gem "pry", "~> 0.9.12.2"
    gem "rspec", "~> 2.14.1"
    gem "factory_girl", "~> 4.2.0"
    gem "coveralls", require: false
  end
end
