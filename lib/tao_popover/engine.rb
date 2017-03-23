require 'tao_on_rails'
require 'tao_popover/component'

module TaoPopover
  class Engine < Rails::Engine

    paths['app/views'] << 'lib/views'

  end
end
