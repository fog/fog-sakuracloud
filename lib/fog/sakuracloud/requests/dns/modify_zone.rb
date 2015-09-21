# coding: utf-8

module Fog
  module DNS
    class SakuraCloud
      class Real
        def modify_zone(options)
          body = {
            "CommonServiceItem"=>{
              "Settings" => options[:settings]
            }
          }

          request(
            :headers => {
              'Authorization' => "Basic #{@auth_encord}"
            },
            :expects  => 200,
            :method => 'PUT',
            :path => "#{Fog::SakuraCloud::SAKURACLOUD_API_ENDPOINT}/commonserviceitem/#{options[:id]}",
            :body => Fog::JSON.encode(body)
          )
        end
      end # Real

      class Mock
        def modify_zone(options)
          response = Excon::Response.new
          response.status = 200
          response.body = {
          }
          response
        end
      end
    end # SakuraCloud
  end # DNS
end # Fog
