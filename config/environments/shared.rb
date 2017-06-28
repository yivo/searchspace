# Several things that must run before initializers...

Rails.application.configure do
  # http://stackoverflow.com/questions/23422522/how-to-specify-asset-host-in-rails-4
  config.action_controller.asset_host = SC.url.root
end
