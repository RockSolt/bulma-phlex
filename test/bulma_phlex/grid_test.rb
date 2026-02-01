# frozen_string_literal: true

require "test_helper"

module BulmaPhlex
  class GridTest < ActiveSupport::TestCase
    include TagOutputAssertions

    def test_renders_div_with_class
      component = Grid.new
      output = component.call { "Content" }

      assert_html_equal <<~HTML, output
        <div class="grid">
          Content
        </div>
      HTML
    end

    def test_fixed_columns
      component = Grid.new(fixed_columns: 3)
      output = component.call { "Content" }

      assert_html_equal <<~HTML, output
        <div class="fixed-grid has-3-cols">
          <div class="grid">
            Content
          </div>
        </div>
      HTML
    end

    def test_auto_count
      component = Grid.new(auto_count: true)
      output = component.call { "Content" }

      assert_html_equal <<~HTML, output
        <div class="fixed-grid has-auto-count">
          <div class="grid">
            Content
          </div>
        </div>
      HTML
    end

    def test_minimum_column_width
      component = Grid.new(minimum_column_width: 10)
      output = component.call { "Content" }

      assert_html_equal <<~HTML, output
        <div class="grid is-col-min-10" >
          Content
        </div>
      HTML
    end

    def test_gap
      component = Grid.new(gap: 2.5)
      output = component.call { "Content" }

      assert_html_equal <<~HTML, output
        <div class="grid is-gap-2.5">
          Content
        </div>
      HTML
    end

    def test_column_gap
      component = Grid.new(column_gap: 4)
      output = component.call { "Content" }

      assert_html_equal <<~HTML, output
        <div class="grid is-column-gap-4">
          Content
        </div>
      HTML
    end

    def test_row_gap
      component = Grid.new(row_gap: 6)
      output = component.call { "Content" }

      assert_html_equal <<~HTML, output
        <div class="grid is-row-gap-6">
          Content
        </div>
      HTML
    end
  end
end
