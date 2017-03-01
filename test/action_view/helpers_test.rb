require 'test_helper'

class TaoPopover::ActionView::HelpersTest < ActiveSupport::TestCase
  include TaoPopover::ActionView::Helpers

  test 'tao_popover' do
    html = tao_popover target_traversal: 'prev', target_selector: 'a' do
      'lalala'
    end
    assert_equal minify_html(html), minify_html(%Q{
      <tao-popover target_traversal=\"prev\" target_selector=\"a\" class=\"tao-popover\">
        <div class=\"tao-popover-content\">
          lalala
        </div>
        <div class=\"tao-popover-arrow\">
          <i class=\"arrow arrow-shadow\"></i>
          <i class=\"arrow arrow-border\"></i>
          <i class=\"arrow arrow-basic\"></i>
        </div>
      </tao-popover>
    })
  end

  private

  def minify_html html
    html.gsub(/>\s+/, ">")
      .gsub(/\s+</, "<")
      .gsub(/\A\s+</, "<")
      .gsub(/>\s+\z/, ">")
  end

end
