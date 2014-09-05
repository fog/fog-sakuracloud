require 'fog/core/model'

module Fog
  module Network
    class SakuraCloud
      class Router < Fog::Model
        identity :id, :aliases => 'ID'
        attribute :name, :aliases => 'Name'
        attribute :description, :aliases => 'Description'
        attribute :server_count, :aliases => 'ServerCount'
        attribute :appliance_count, :aliases => 'ApplianceCount'
        attribute :subnets, :aliases => 'Subnets'
        attribute :ipv6nets, :aliases => 'IPv6Nets'
        attribute :internet, :aliases => 'Internet'
        attribute :bridge, :aliases => 'Bridge'


        def delete
          service.delete_router(identity)
          true
        end
        alias_method :destroy, :delete

        def save
          requires :name
          if @attributes[:networkmasklen]
            Fog::Logger.warning("Create Router with public subnet")
            data = service.create_router(@attributes).body["Internet"]
            Fog::Logger.warning("Waiting available new router...")
            new_data = router_available?(service, data["ID"])
            merge_attributes(new_data)
          else
            Fog::Logger.warning("Create simple Switch")
            data = service.create_router(@attributes).body["Switch"]
            merge_attributes(data)
          end
          true
        end

        def router_available?(network, router_id)
          until network.routers.find {|r| r.internet["ID"] == router_id}
            print '.'
            sleep 2
          end
          ::JSON.parse((network.routers.find {|r| r.internet["ID"] == router_id}).to_json)
        end
      end
    end
  end
end
