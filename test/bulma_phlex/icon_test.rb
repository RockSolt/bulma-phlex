# frozen_string_literal: true

require "test_helper"

module BulmaPhlex
  class IconTest < Minitest::Test
    include TagOutputAssertions

    def test_icon
      result = BulmaPhlex::Icon.new("fa-solid fa-home").call

      assert_html_equal <<~HTML, result
        <span class="icon">
          <i class="fa-solid fa-home"></i>
        </span>
      HTML
    end

    def test_icon_with_text_on_right
      result = Icon.new("fa-solid fa-home", text_right: "Home").call

      assert_html_equal <<~HTML, result
        <span class="icon-text">
          <span class="icon">
            <i class="fa-solid fa-home", aria-hidden="true"></i>
          </span>
          <span>Home</span>
        </span>
      HTML
    end

    def test_icon_with_text_on_left
      result = Icon.new("fa-solid fa-home", text_left: "Home").call

      assert_html_equal <<~HTML, result
        <span class="icon-text">
          <span>Home</span>
          <span class="icon">
            <i class="fa-solid fa-home" aria-hidden="true"></i>
          </span>
        </span>
      HTML
    end

    def test_icon_with_text_and_nowrap
      result = Icon.new("fa-solid fa-home", text_left: "Home", nowrap: true).call

      assert_html_equal <<~HTML, result
        <span class="icon-text is-flex-wrap-nowrap">
          <span>Home</span>
          <span class="icon">
            <i class="fa-solid fa-home" aria-hidden="true"></i>
          </span>
        </span>
      HTML
    end

    def test_icon_with_size
      result = Icon.new("fa-solid fa-home", size: :medium).call

      assert_html_equal <<~HTML, result
        <span class="icon is-medium">
          <i class="fa-solid fa-home"></i>
        </span>
      HTML
    end

    def test_icon_with_color
      result = Icon.new("fa-solid fa-home", color: :primary).call

      assert_html_equal <<~HTML, result
        <span class="icon has-text-primary">
          <i class="fa-solid fa-home"></i>
        </span>
      HTML
    end

    def test_icon_with_size_and_color
      result = Icon.new("fa-solid fa-home", size: :large, color: :danger).call

      assert_html_equal <<~HTML, result
        <span class="icon is-large has-text-danger">
          <i class="fa-solid fa-home"></i>
        </span>
      HTML
    end

    def test_icon_with_left_flag
      result = Icon.new("fa-solid fa-home", left: true).call

      assert_html_equal <<~HTML, result
        <span class="icon is-left">
          <i class="fa-solid fa-home"></i>
        </span>
      HTML
    end

    def test_icon_with_right_flag
      result = Icon.new("fa-solid fa-home", right: true).call

      assert_html_equal <<~HTML, result
        <span class="icon is-right">
          <i class="fa-solid fa-home"></i>
        </span>
      HTML
    end

    def test_with_additional_html_attributes
      result = Icon.new("fa-solid fa-home", id: "home-icon", data: { test: "value" }).call

      assert_html_equal <<~HTML, result
        <span class="icon" id="home-icon" data-test="value">
          <i class="fa-solid fa-home"></i>
        </span>
      HTML
    end

    def test_with_icon_attributes
      result = Icon.new("fa-solid fa-home", icon_attributes: { id: "home-icon", data: { test: "value" } }).call

      assert_html_equal <<~HTML, result
        <span class="icon">
          <i class="fa-solid fa-home" id="home-icon" data-test="value"></i>
        </span>
      HTML
    end
  end
end
