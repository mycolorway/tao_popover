require 'test_helper'

class TaoPopoverTest < ActiveSupport::TestCase

  test 'version number' do
    assert TaoPopover::VERSION.is_a? String
  end

  test 'TaoPopover::Engine inherits from Rails::Engine' do
    assert TaoPopover::Engine < Rails::Engine
  end

  test 'TaoPopover::Component inherits from TaoOnRails::Components::Base' do
    assert TaoPopover::Component < TaoOnRails::Components::Base
  end

end
