# encoding: UTF-8
# frozen_string_literal: true

# https://robots.thoughtbot.com/automatically-wait-for-ajax-with-capybara
module WaitForAJAX
  def wait_for_ajax
    Timeout.timeout(Capybara.default_max_wait_time) do
      loop until finished_all_ajax_requests?
    end
  end

  def finished_all_ajax_requests?
    page.evaluate_script('jQuery.active').zero?
  end
end

RSpec.configuration.include WaitForAJAX, type: :feature
