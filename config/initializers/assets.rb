Rails.application.configure do
  # Version of your assets, change this if you want to expire all your assets.
  config.assets.version                 = '1.0'
  config.assets.check_precompiled_asset = false

  config.assets.paths << Rails.root.join('app/assets/templates')
  config.assets.paths << Rails.root.join('vendor/assets')
  config.assets.paths.map!(&:to_s)
  config.assets.paths.uniq!
  config.assets.paths.delete(Rails.root.join('vendor/assets/bower_components').to_s)

  # Precompile additional assets.
  config.assets.precompile += %w()

  # http://stackoverflow.com/questions/23422522/how-to-specify-asset-host-in-rails-4
  config.action_controller.asset_host = SC.url.root
end
