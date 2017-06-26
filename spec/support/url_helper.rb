# encoding: UTF-8
# frozen_string_literal: true

RSpec.configure do |config|
  config.include URLHelpers

  config.before :each do
    self.default_url_options = Rails.application.routes.default_url_options
  end
end
