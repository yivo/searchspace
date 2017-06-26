module SC
  class << self
    def url
      @url ||= Application::URLInformation.new
    end
  end

  class Application::URLInformation
    attr_reader :host, :host_with_port, :protocol, :port, :root

    def initialize
      if Rails.env.production?
        @host           = 'searchspace.website'
        @host_with_port = 'searchspace.website'
        @protocol       = 'http'
        @port           = nil
        @root           = 'http://searchspace.website'
      else
        host = ENV['RAILS_HOST'] || if ARGV.join('').match?(/binding/)
                 require 'socket'
                 Socket.ip_address_list.detect { |intf| intf.ipv4_private? }&.ip_address
               else
                 'localhost'
               end

        @host           = host
        @host_with_port = "#{host}:3000"
        @protocol       = 'http'
        @port           = 3000
        @root           = "http://#{host}:3000"
      end
    end
  end
end
