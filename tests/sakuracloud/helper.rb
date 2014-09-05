def sakuracloud_volume_service
  Fog::Volume[:sakuracloud]
end

def sakuracloud_compute_service
  Fog::Compute[:sakuracloud]
end
