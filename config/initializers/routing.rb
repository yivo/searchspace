Rails.application.configure do
  { host:           SC.url.host,
    port:           SC.url.port,
    protocol:       SC.url.protocol,
    trailing_slash: true
  }.tap do |url_options|
    config.action_controller.default_url_options = url_options
    # config.action_mailer.default_url_options    = url_options
    routes.default_url_options                   = url_options
  end
end
