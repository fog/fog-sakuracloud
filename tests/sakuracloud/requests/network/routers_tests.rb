# coding: utf-8
Shindo.tests('Fog::Network[:sakuracloud] | list_routers request', ['sakuracloud', 'network']) do

  @routers_format = {
    'Index'          => Integer,
    'ID'             => Integer,
    'Name'           => String,
    'ServerCount'    => Integer,
    'ApplianceCount' => Integer,
    'Subnets'        => Array
  }

  tests('success') do

    tests('#list_routers') do
      disks = sakuracloud_volume_service.list_disks
      test 'returns a Hash' do
        disks.body.is_a? Hash
      end
      if Fog.mock?
        tests('Disks').formats(@disks_format, false) do
          disks.body['Disks'].first
        end
      else
        returns(200) { disks.status }
        returns(true) { disks.body.is_a? Hash }
      end
    end
  end
end

Shindo.tests('Fog::Network[:sakuracloud] | create_router request', ['sakuracloud', 'network']) do
  tests('success') do
    tests('#create_simple_switch') do
      disks = sakuracloud_network_service.create_disk(:name => 'foobar')
      test 'returns a Hash' do
        disks.body.is_a? Hash
      end

      unless Fog.mock?
        returns(201) { disks.status }
        returns(true) { disks.body.is_a? Hash }
      end
    end

    tests('#create_router_with_internet_access') do
      router = sakuracloud_network_service.create_disk(:name => 'foobar', :networkmasklen => 28)
      test 'returns a Hash' do
        router.body.is_a? Hash
      end

      unless Fog.mock?
        returns(202) { router.status }
        returns(true) { router.body.is_a? Hash }
      end
    end
  end
end
