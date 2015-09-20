# coding: utf-8

module Fog
  module Network
    class SakuraCloud
      class Real
        def list_interfaces(options = {})
          filter = {
            "Include" => [
              "ID",
              "MACAddress",
              "IPAddress",
              "UserIPAddress",
              "Switch.ID",
              "Server.ID"]
          }
          request(
            :headers => {
              'Authorization' => "Basic #{@auth_encord}"
            },
            :method => 'GET',
            :path => "#{Fog::SakuraCloud::SAKURACLOUD_API_ENDPOINT}/interface",
            :query => URI.encode(Fog::JSON.encode(filter))
          )
        end
      end

      class Mock
        def list_interfaces(options = {})
          response = Excon::Response.new
          response.status = 200
          response.body = {
          }
          response
        end
      end
    end
  end
end
