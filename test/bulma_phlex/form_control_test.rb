# frozen_string_literal: true

require "test_helper"

module BulmaPhlex
  class FormControlTest < ActiveSupport::TestCase
    include TagOutputAssertions

    def test_renders_div_with_class
      component = FormControl.new
      output = component.call { "Content" }

      expected_html = <<~HTML
        <div class="control">
          Content
        </div>
      HTML

      assert_html_equal expected_html, output
    end

    def test_renders_div_with_additional_classes
      component = FormControl.new(class: "is-expanded")
      output = component.call { "Content" }

      expected_html = <<~HTML
        <div class="control is-expanded">
          Content
        </div>
      HTML

      assert_html_equal expected_html, output
    end
  end
end
