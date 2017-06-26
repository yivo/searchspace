Rails.application.configure do
  # Version of your assets, change this if you want to expire all your assets.
  config.assets.version                 = '1.0'
  config.assets.check_precompiled_asset = false

  # Precompile additional assets.
  config.assets.precompile += %w()

  # http://stackoverflow.com/questions/23422522/how-to-specify-asset-host-in-rails-4
  config.action_controller.asset_host = SC.url.root
end
