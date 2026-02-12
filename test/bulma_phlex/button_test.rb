# frozen_string_literal: true

require "test_helper"

module BulmaPhlex
  class ButtonTest < Minitest::Test
    include TagOutputAssertions

    def test_button
      component = BulmaPhlex::Button.new
      result = component.call { "Click Me" }

      assert_html_equal <<~HTML, result
        <button class="button">
          Click Me
        </button>
      HTML
    end

    def test_color
      component = BulmaPhlex::Button.new(color: "primary")
      result = component.call { "Primary Button" }

      assert_html_equal <<~HTML, result
        <button class="button is-primary">
          Primary Button
        </button>
      HTML
    end

    def test_mode
      component = BulmaPhlex::Button.new(color: "primary", mode: "dark")
      result = component.call { "Dark Primary Button" }

      assert_html_equal <<~HTML, result
        <button class="button is-primary is-dark">
          Dark Primary Button
        </button>
      HTML
    end

    def test_size
      component = BulmaPhlex::Button.new(size: "large")
      result = component.call { "Large Button" }

      assert_html_equal <<~HTML, result
        <button class="button is-large">
          Large Button
        </button>
      HTML
    end

    def test_responsive
      component = BulmaPhlex::Button.new(responsive: true)
      result = component.call { "Responsive Button" }

      assert_html_equal <<~HTML, result
        <button class="button is-responsive">
          Responsive Button
        </button>
      HTML
    end

    def test_fullwidth
      component = BulmaPhlex::Button.new(fullwidth: true)
      result = component.call { "Fullwidth Button" }

      assert_html_equal <<~HTML, result
        <button class="button is-fullwidth">
          Fullwidth Button
        </button>
      HTML
    end

    def test_outlined
      component = BulmaPhlex::Button.new(outlined: true)
      result = component.call { "Outlined Button" }

      assert_html_equal <<~HTML, result
        <button class="button is-outlined">
          Outlined Button
        </button>
      HTML
    end

    def test_inverted
      component = BulmaPhlex::Button.new(inverted: true)
      result = component.call { "Inverted Button" }

      assert_html_equal <<~HTML, result
        <button class="button is-inverted">
          Inverted Button
        </button>
      HTML
    end

    def test_rounded
      component = BulmaPhlex::Button.new(rounded: true)
      result = component.call { "Rounded Button" }

      assert_html_equal <<~HTML, result
        <button class="button is-rounded">
          Rounded Button
        </button>
      HTML
    end

    def test_icon_left
      component = BulmaPhlex::Button.new(icon_left: "fas fa-pencil")
      result = component.call { "Button with Left Icon" }

      assert_html_equal <<~HTML, result
        <button class="button">
          <span class="icon">
            <i class="fas fa-pencil"></i>
          </span>
          Button with Left Icon
        </button>
      HTML
    end

    def test_icon_right
      component = BulmaPhlex::Button.new(icon_right: "fas fa-trash")
      result = component.call { "Button with Right Icon" }

      assert_html_equal <<~HTML, result
        <button class="button">
          Button with Right Icon
          <span class="icon">
            <i class="fas fa-trash"></i>
          </span>
        </button>
      HTML
    end

    def test_icon
      component = BulmaPhlex::Button.new(icon: "fas fa-check")
      result = component.call

      assert_html_equal <<~HTML, result
        <button class="button">
          <span class="icon">
            <i class="fas fa-check"></i>
          </span>
        </button>
      HTML
    end

    def test_with_html_attributes
      component = BulmaPhlex::Button.new(color: "primary", data: { test: "value" }, id: "my-button")
      result = component.call { "Button with HTML Attributes" }

      assert_html_equal <<~HTML, result
        <button class="button is-primary" data-test="value" id="my-button">
          Button with HTML Attributes
        </button>
      HTML
    end
  end
end
