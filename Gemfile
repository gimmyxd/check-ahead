# frozen_string_literal: true

source 'https://rubygems.org'

# Specify your gem's dependencies in check-ahead.gemspec
gemspec

group :developmen, :test do
  gem 'pry-byebug'
  gem 'rspec'
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rspec', require: false
end

local_gemfile = File.expand_path('Gemfile.local', __dir__)
eval_gemfile local_gemfile if File.exist?(local_gemfile)
