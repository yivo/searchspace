# encoding: UTF-8
# frozen_string_literal: true

RSpec.configure do |config|
  config.include URLHelpers

  config.before :each do
    # Runs only if type is passed to describe.
    if respond_to?(:default_url_options=)
      self.default_url_options = Rails.application.routes.default_url_options
    end
  end
end
