module TaoPopover
  module ActionView
    module Helpers

      include ::ActionView::Helpers
      include ::ActionView::Context

      def tao_popover(attributes = nil, &block)
        content = %Q{
          <div class="tao-popover-content">
            #{capture(&block)}
          </div>
          <div class="tao-popover-arrow">
            <i class="arrow arrow-shadow"></i>
            <i class="arrow arrow-border"></i>
            <i class="arrow arrow-basic"></i>
          </div>
        }.html_safe
        content_tag('tao-popover', content, attributes)
      end

    end
  end
end
