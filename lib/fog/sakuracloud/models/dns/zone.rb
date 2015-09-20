require 'fog/core/model'

module Fog
  module DNS
    class SakuraCloud
      class Zone < Fog::Model
        identity :id, :aliases => 'ID'
        attribute :name, :aliases => 'Name'
        attribute :description, :aliases => 'Description'
        attribute :status, :aliases => 'Status'
        attribute :zone
        attribute :nameservers

        def delete
          service.delete_zone(identity)
          true
        end
        alias_method :destroy, :delete

        def save
          requires :name
          Fog::Logger.warning("Create DNS Zone")
          data = service.create_zone(@attributes).body["CommonServiceItem"]
          merge_attributes(data)
          true
        end
      end
    end
  end
end
