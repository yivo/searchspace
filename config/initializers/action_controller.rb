Rails.application.configure do
  config.action_controller.include_all_helpers = false

  # https://github.com/rails/rails/issues/13766
  config.action_dispatch.perform_deep_munge = false
end
