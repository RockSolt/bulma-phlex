# frozen_string_literal: true

require "test_helper"

module BulmaPhlex
  class FormControlTest < ActiveSupport::TestCase
    include TagOutputAssertions

    def test_renders_div_with_class
      component = FormControl.new
      output = component.call { "Content" }

      assert_html_equal <<~HTML, output
        <div class="control">
          Content
        </div>
      HTML
    end

    def test_renders_div_with_additional_html_attributes
      component = FormControl.new(class: "is-expanded", data: { test: "value" })
      output = component.call { "Content" }

      assert_html_equal <<~HTML, output
        <div class="control is-expanded" data-test="value">
          Content
        </div>
      HTML
    end

    def test_renders_icon_left
      component = FormControl.new(icon_left: "fas fa-check")
      output = component.call { "Content" }

      assert_html_equal <<~HTML, output
        <div class="control has-icons-left">
          Content
          <span class="icon is-small is-left">
            <i class="fas fa-check"></i>
          </span>
        </div>
      HTML
    end

    def test_renders_icon_right
      component = FormControl.new(icon_right: "fas fa-check")
      output = component.call { "Content" }

      assert_html_equal <<~HTML, output
        <div class="control has-icons-right">
          Content
          <span class="icon is-small is-right">
            <i class="fas fa-check"></i>
          </span>
        </div>
      HTML
    end
  end
end
