require File.expand_path('../boot', __FILE__)

require 'rails'
require 'action_controller/railtie'
require 'action_view/railtie'
require 'sprockets/railtie'

Bundler.require *Rails.groups

module SC
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Now we are able to require "lib/script_in_lib.rb".
    $LOAD_PATH.unshift File.expand_path('../../', __FILE__)

    # Now we aren't able to require "script_in_lib.rb".
    $LOAD_PATH.delete  File.expand_path('../../lib', __FILE__)

    # Autoloads directly from app: no more app/my_module/my_module/my_class -> app/my_module/my_class.rb.
    config.autoload_paths << Rails.root.join('app')

    # Autoloads from lib.
    config.autoload_paths << Rails.root.join('lib')

    # Disables reloading for lib.
    config.autoload_once_paths << Rails.root.join('lib')
  end
end

require File.expand_path('../url', __FILE__)
