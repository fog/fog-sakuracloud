require 'fog/core/model'

module Fog
  module Network
    class SakuraCloud
      class Router < Fog::Model
        identity :id, :aliases => 'ID'
        attribute :name, :aliases => 'Name'

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
