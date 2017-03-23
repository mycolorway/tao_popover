module TaoPopover
  class Component < TaoOnRails::Components::Base

    def initialize view, options = {}
      super

      if @options[:class].present?
        @options[:class] += ' tao-popover'
      else
        @options[:class] = 'tao-popover'
      end
    end

  end
end
