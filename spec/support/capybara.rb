require 'capybara'
require 'capybara/rspec'
require 'capybara/rails'
require 'selenium-webdriver'
require 'chromedriver/helper'

Capybara.configure do |config|
  Rails.application.routes.default_url_options.tap do |url_options|
    config.app_host            = "#{url_options[:protocol]}://#{url_options[:host]}:#{url_options[:port]}"
    config.default_host        = "#{url_options[:protocol]}://#{url_options[:host]}:#{url_options[:port]}"
    config.server_host         = url_options[:host]
    config.server_port         = url_options[:port]
    config.always_include_port = false
  end
end

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.javascript_driver = :chrome

RSpec.configure do |config|
  config.before '@javascript' do
    page.driver.browser.tap do |browser|
      if browser.respond_to?(:manage)
        browser.manage.window.resize_to(1280, 800)
        browser.manage.window.move_to(0, 0)
      end
    end
  end
end
