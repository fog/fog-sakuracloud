require File.expand_path('../../fog/tests/helper', __FILE__)
helpers = Dir.glob(File.expand_path('../../', __FILE__) + '/fog/tests/helpers/**/*.rb')
helpers.map {|h| load h}

