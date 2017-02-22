require 'tao_on_rails'

module TaoPopover
  class Engine < Rails::Engine

    initializer "tao_on_rails.view_helpers" do |app|
      ActiveSupport.on_load :action_view do
        include TaoOnRails::ActionView::Helpers
      end
    end

  end
end
