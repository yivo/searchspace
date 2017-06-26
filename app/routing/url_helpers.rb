# http://stackoverflow.com/questions/16720514/how-to-use-url-helpers-in-lib-modules-and-set-host-for-multiple-environments
module URLHelpers
  class << self
    def method_missing(method, *args, &block)
      if url_helpers.respond_to?(method)
        url_helpers.send(method, *args, &block)
      else
        super
      end
    end

    def respond_to_missing?(method, include_private = false)
      url_helpers.respond_to?(method, include_private)
    end

  private
    def url_helpers
      @url_helpers ||= Rails.application.routes.url_helpers
    end
  end
end