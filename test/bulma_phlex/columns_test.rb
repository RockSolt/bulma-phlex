# frozen_string_literal: true

require "test_helper"

module BulmaPhlex
  class ColumnsTest < ActiveSupport::TestCase
    include TagOutputAssertions

    def test_renders_div_with_class
      component = Columns.new
      output = component.call { "Content" }

      assert_html_equal <<~HTML, output
        <div class="columns">
          Content
        </div>
      HTML
    end

    def test_html_attributes
      component = Columns.new(id: "my-columns", data: { test: "value" })
      output = component.call { "Content" }

      assert_html_equal <<~HTML, output
        <div class="columns" id="my-columns" data-test="value">
          Content
        </div>
      HTML
    end

    def test_minimum_breakpoint
      component = Columns.new(minimum_breakpoint: :desktop)
      output = component.call { "Content" }

      assert_html_equal <<~HTML, output
        <div class="columns is-desktop">
          Content
        </div>
      HTML
    end

    def test_multiline
      component = Columns.new(multiline: true)
      output = component.call { "Content" }

      assert_html_equal <<~HTML, output
        <div class="columns is-multiline">
          Content
        </div>
      HTML
    end

    def test_gap
      component = Columns.new(gap: 4)
      output = component.call { "Content" }

      assert_html_equal <<~HTML, output
        <div class="columns is-4">
          Content
        </div>
      HTML
    end

    def test_gap_by_breakpoint
      component = Columns.new(gap: { mobile: 2, desktop: 5 })
      output = component.call { "Content" }

      assert_html_equal <<~HTML, output
        <div class="columns is-2-mobile is-5-desktop">
          Content
        </div>
      HTML
    end

    def test_centered
      component = Columns.new(centered: true)
      output = component.call { "Content" }

      assert_html_equal <<~HTML, output
        <div class="columns is-centered">
          Content
        </div>
      HTML
    end

    def test_vcentered
      component = Columns.new(vcentered: true)
      output = component.call { "Content" }

      assert_html_equal <<~HTML, output
        <div class="columns is-vcentered">
          Content
        </div>
      HTML
    end
  end
end
