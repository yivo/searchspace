Rails.application.configure do
  # http://edgeguides.rubyonrails.org/security.html#default-headers
  config.action_dispatch.default_headers.clear.merge! \
    'Cache-Control' => 'private, no-store, max-age=0, no-cache, must-revalidate, post-check=0, pre-check=0',
    'Pragma'        => 'no-cache',
    'Expires'       => 'Fri, 01 Jan 1970 00:00:00 GMT'
  config.middleware.delete Rack::ETag
end
