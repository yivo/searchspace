source 'https://rubygems.org'

gem 'rails', '~> 4.2'
gem 'uglifier', '~> 3.2'
gem 'sprockets-rails', '~> 3.2'
gem 'browser', '~> 2.0'
gem 'fast_blank', '>= 1.0.0'
gem 'memoist', '~> 0.15'
gem 'sassc-rails', '~> 1.3'
gem 'slim', '~> 3.0'
gem 'coffee-rails', '~> 4.1'
gem 'bower-rails', '~> 0.11'
gem 'pug-rails', '~> 2.0'
gem 'method-not-implemented', '~> 1.0'
gem 'faraday', '~> 0.12.1'
gem 'sassc-rails-svg-data-url', '~> 1.0'

group :development do
  gem 'faker'
  gem 'pry-byebug'
end

group :development, :test do
  { require: false }.tap do |options|
    # Testing
    gem 'rspec-rails',         '~> 3.5',  options
    gem 'capybara',            '~> 2.13', options
    gem 'selenium-webdriver',  '~> 3.3',  options
    gem 'chromedriver-helper', '~> 1.1',  options

    # Deployment
    gem 'capistrano',               '~> 3.6', options
    gem 'capistrano-rails',         '~> 1.3', options
    gem 'capistrano-passenger',     '~> 0.2', options
    gem 'capistrano-rbenv-support', '~> 1.0', options
  end
end
