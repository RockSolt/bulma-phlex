# frozen_string_literal: true

require "test_helper"

module BulmaPhlex
  class IconTest < Minitest::Test
    include TagOutputAssertions

    def test_icon
      result = BulmaPhlex::Icon.new("fas fa-home").call

      assert_html_equal <<~HTML, result
        <span class="icon">
          <i class="fas fa-home"></i>
        </span>
      HTML
    end

    def test_icon_with_text_on_right
      result = Icon.new("fas fa-home", text_right: "Home").call

      assert_html_equal <<~HTML, result
        <span class="icon-text">
          <span class="icon">
            <i class="fas fa-home"></i>
          </span>
          <span>Home</span>
        </span>
      HTML
    end

    def test_icon_with_text_on_left
      result = Icon.new("fas fa-home", text_left: "Home").call

      assert_html_equal <<~HTML, result
        <span class="icon-text">
          <span>Home</span>
          <span class="icon">
            <i class="fas fa-home"></i>
          </span>
        </span>
      HTML
    end

    def test_icon_with_size
      result = Icon.new("fas fa-home", size: :medium).call

      assert_html_equal <<~HTML, result
        <span class="icon is-medium">
          <i class="fas fa-home"></i>
        </span>
      HTML
    end

    def test_icon_with_color
      result = Icon.new("fas fa-home", color: :primary).call

      assert_html_equal <<~HTML, result
        <span class="icon has-text-primary">
          <i class="fas fa-home"></i>
        </span>
      HTML
    end

    def test_icon_with_size_and_color
      result = Icon.new("fas fa-home", size: :large, color: :danger).call

      assert_html_equal <<~HTML, result
        <span class="icon is-large has-text-danger">
          <i class="fas fa-home"></i>
        </span>
      HTML
    end

    def test_icon_with_left_flag
      result = Icon.new("fas fa-home", left: true).call

      assert_html_equal <<~HTML, result
        <span class="icon is-left">
          <i class="fas fa-home"></i>
        </span>
      HTML
    end

    def test_icon_with_right_flag
      result = Icon.new("fas fa-home", right: true).call

      assert_html_equal <<~HTML, result
        <span class="icon is-right">
          <i class="fas fa-home"></i>
        </span>
      HTML
    end

    def test_with_additional_html_attributes
      result = Icon.new("fas fa-home", id: "home-icon", data: { test: "value" }).call

      assert_html_equal <<~HTML, result
        <span class="icon" id="home-icon" data-test="value">
          <i class="fas fa-home"></i>
        </span>
      HTML
    end
  end
end
