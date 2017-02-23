require 'tao_on_rails'
require 'tao_popover/action_view/helpers'

module TaoPopover
  class Engine < Rails::Engine

    initializer "tao_popover.view_helpers" do |app|
      ActiveSupport.on_load :action_view do
        include TaoPopover::ActionView::Helpers
      end
    end

  end
end
