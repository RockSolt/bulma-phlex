# frozen_string_literal: true

require "test_helper"

module BulmaPhlex
  class TagTest < Minitest::Test
    include TagOutputAssertions

    def test_renders_span_tag
      component = BulmaPhlex::Tag.new("Sample Tag")
      result = component.call

      expected_html = '<span class="tag">Sample Tag</span>'
      assert_html_equal expected_html, result
    end

    def test_renders_color
      component = BulmaPhlex::Tag.new("Sample Tag", color: "primary")
      result = component.call

      expected_html = '<span class="tag is-primary">Sample Tag</span>'
      assert_html_equal expected_html, result
    end

    def test_renders_light_color
      component = BulmaPhlex::Tag.new("Sample Tag", light: "warning")
      result = component.call

      expected_html = <<~HTML
        <span class="tag is-warning is-light">Sample Tag</span>
      HTML
      assert_html_equal expected_html, result
    end

    def test_renders_size
      component = BulmaPhlex::Tag.new("Sample Tag", size: "medium")
      result = component.call

      expected_html = '<span class="tag is-medium">Sample Tag</span>'
      assert_html_equal expected_html, result
    end

    def test_renders_rounded
      component = BulmaPhlex::Tag.new("Sample Tag", rounded: true)
      result = component.call

      expected_html = '<span class="tag is-rounded">Sample Tag</span>'
      assert_html_equal expected_html, result
    end

    def test_renders_anchor_tag
      component = BulmaPhlex::Tag.new("Link Tag", href: "/sample-link", size: "large")
      result = component.call

      expected_html = <<~HTML
        <a class="tag is-large" href="/sample-link">Link Tag</a>
      HTML

      assert_html_equal expected_html, result
    end

    def test_renders_anchor_tag_with_delete
      component = BulmaPhlex::Tag.new("Deletable Tag", href: "/deletable-link", delete: true)
      result = component.call

      expected_html = <<~HTML
        <a class="tag" href="/deletable-link">
          Deletable Tag
          <span class="delete is-small"></span>
        </a>
      HTML

      assert_html_equal expected_html, result
    end

    def test_renders_button_tag
      component = BulmaPhlex::Tag.new("Button Tag", delete: true)
      result = component.call

      expected_html = <<~HTML
        <button class="tag">
          Button Tag
          <span class="delete is-small"></span>
        </button>
      HTML

      assert_html_equal expected_html, result
    end

    def test_renders_button_tag_with_data_action
      component = BulmaPhlex::Tag.new("Action Tag", data: { action: "delete" }, color: "info")
      result = component.call

      expected_html = <<~HTML
        <button class="tag is-info" data-action="delete">Action Tag</button>
      HTML

      assert_html_equal expected_html, result
    end

    def test_renders_medium_button_with_small_delete
      component = BulmaPhlex::Tag.new("Medium Delete", delete: true, size: "medium")
      result = component.call

      expected_html = <<~HTML
        <button class="tag is-medium" >
          Medium Delete
          <span class="delete is-small"></span>
        </button>
      HTML

      assert_html_equal expected_html, result
    end

    def test_renders_large_tag_with_delete
      component = BulmaPhlex::Tag.new("Large Deletable", delete: true, size: "large")
      result = component.call

      expected_html = <<~HTML
        <button class="tag is-large" >
          Large Deletable
          <span class="delete"></span>
        </button>
      HTML

      assert_html_equal expected_html, result
    end
  end
end
