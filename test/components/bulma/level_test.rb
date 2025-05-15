require "test_helper"

class Components::Bulma::LevelTest < Minitest::Test
  include TagOutputAssertions

  def test_renders_level_with_left_and_right
    component = Components::Bulma::Level.new

    result = component.call do |level|
      level.left do
        "Left Content"
      end

      level.right do
        "Right Content"
      end
    end

    expected_html = <<~HTML
      <div class="level">
        <div class="level-left">
          <div class="level-item">Left Content</div>
        </div>
        <div class="level-right">
          <div class="level-item">Right Content</div>
        </div>
      </div>
    HTML

    assert_html_equal expected_html, result
  end

  def test_multiple_items_on_same_side
    component = Components::Bulma::Level.new

    result = component.call do |level|
      level.left do
        "Left Item 1"
      end

      level.left do
        "Left Item 2"
      end
    end

    expected_html = <<~HTML
      <div class="level">
        <div class="level-left">
          <div class="level-item">Left Item 1</div>
          <div class="level-item">Left Item 2</div>
        </div>
        <div class="level-right"></div>
      </div>
    HTML

    assert_html_equal expected_html, result
  end
end
