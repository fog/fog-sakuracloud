module Fog
  module DNS
    class SakuraCloud < Fog::Service
      requires     :sakuracloud_api_token
      requires     :sakuracloud_api_token_secret

      recognizes   :sakuracloud_api_url

      model_path 'fog/sakuracloud/models/dns'
      model      :zone
      collection :zones

      request_path 'fog/sakuracloud/requests/dns'
      request      :list_zones
      request      :create_zone
      request      :delete_zone
      request      :modify_zone

      class Real
        def initialize(options = {})
          @auth_encord = Base64.strict_encode64([
            options[:sakuracloud_api_token],
            options[:sakuracloud_api_token_secret]
          ].join(':'))
          Fog.credentials[:sakuracloud_api_token]        = options[:sakuracloud_api_token]
          Fog.credentials[:sakuracloud_api_token_secret] = options[:sakuracloud_api_token_secret]

          @sakuracloud_api_url = options[:sakuracloud_api_url] || 'https://secure.sakura.ad.jp'

          @connection = Fog::Core::Connection.new(@sakuracloud_api_url)
        end

        def request(params)
          response = parse @connection.request(params)
          response
        end

        private
        def parse(response)
          return response if response.body.empty?
          response.body = Fog::JSON.decode(response.body)
          response
        end
      end

      class Mock
        def self.data
          @data ||= Hash.new do |hash, key|
            hash[key] = {
              :notes => []
            }
          end
        end

        def self.reset
          @data = nil
        end

        def initialize(options={})
          @sakuracloud_api_token        = options[:sakuracloud_api_token]
          @sakuracloud_api_token_secret = options[:sakuracloud_api_token_secret]
        end

        def data
          self.class.data[@sakuracloud_api_token]
          self.class.data[@sakuracloud_api_token_secret]
        end

        def reset_data
          self.class.data.delete(@sakuracloud_api_token)
          self.class.data.delete(@sakuracloud_api_token_secret)
        end
      end
    end
  end
end
