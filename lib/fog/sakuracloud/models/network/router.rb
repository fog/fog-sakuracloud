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


#        def delete
#          service.delete_router(identity)
#          true
#        end
#        alias_method :destroy, :delete

#        def save
#          data = service.create_router(@attributes).body["Switch"]
#          merge_attributes(data)
#          true
#        end
      end
    end
  end
end
