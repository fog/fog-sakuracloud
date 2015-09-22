require 'fog/core/model'

module Fog
  module Volume
    class SakuraCloud
      class Disk < Fog::Model
        identity :id, :aliases => 'ID'
        attribute :name, :aliases => 'Name'
        attribute :connection, :aliases => 'Connection'
        attribute :availability, :aliases => 'Availability'
        attribute :plan, :aliases => 'Plan'
        attribute :size_mb, :aliases => 'SizeMB'
        attribute :source_disk, :aliases => 'SourceDisk'
        attribute :source_archive, :aliases => 'SourceArchive'

        def delete
          service.delete_disk(identity)
          true
        end
        alias_method :destroy, :delete

        def save
          requires :name, :plan, :source_archive
          data = service.create_disk(@attributes[:name], @attributes[:plan], @attributes[:source_archive]).body["Disk"]
          merge_attributes(data)
          true
        end

        def configure(sshkey_id)
          requires :id
          service.configure_disk(@attributes[:id], sshkey_id )
          true
        end

        def carve_hostname_on_disk(hostname)
          requires :id
          service.carve_hostname_on_disk(@attributes[:id], hostname )
          true
        end

        def associate_ip(ipaddress, networkmasklen, defaultroute)
          subnet ={
            :ipaddress => ipaddress,
            :networkmasklen => networkmasklen,
            :defaultroute => defaultroute
          }
          requires :id
          service.associate_ip_to_disk(@attributes[:id], subnet )
          true
        end

        def register_script(notes)
          note_ids = []
          note_ids << notes
          requires :id
          service.register_note_to_disk(@attributes[:id], note_ids.flatten )
          true
        end
      end
    end
  end
end
