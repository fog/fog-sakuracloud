require 'fog/core'
require 'fog/json'

module Fog
  module Compute
    autoload :SakuraCloud, File.expand_path('../sakuracloud/compute', __FILE__)
  end

  module Network
    autoload :SakuraCloud, File.expand_path('../sakuracloud/network', __FILE__)
  end

  module Volume
    autoload :SakuraCloud, File.expand_path('../sakuracloud/volume', __FILE__)
  end

  module DNS
    autoload :SakuraCloud, File.expand_path('../sakuracloud/dns', __FILE__)
  end

  module SakuraCloud
    extend Fog::Provider

    SAKURACLOUD_API_VERSION = '1.1' unless defined? SAKURACLOUD_API_VERSION
    SAKURACLOUD_API_ZONE = "is1b" unless defined? SAKURACLOUD_API_ZONE
    SAKURACLOUD_API_ENDPOINT = "/cloud/zone/#{SAKURACLOUD_API_ZONE}/api/cloud/#{SAKURACLOUD_API_VERSION}/"

    # Miscs
    ## Startup Script
    autoload :Script,      File.expand_path('../sakuracloud/script', __FILE__)

    service(:compute, 'Compute')
    service(:volume,  'Volume')
    service(:network, 'Network')
    service(:script,  'Script')
    service(:dns,     'DNS')
  end
end
