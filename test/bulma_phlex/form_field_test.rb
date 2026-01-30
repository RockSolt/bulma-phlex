# frozen_string_literal: true

require "test_helper"

module BulmaPhlex
  class FormFieldTest < Minitest::Test
    include TagOutputAssertions

    Label = Class.new(Phlex::HTML) do
      def view_template = label { "Label Here" }
    end

    Input = Class.new(Phlex::HTML) do
      def view_template = input(name: "test_input", type: "text")
    end

    def test_renders_label_from_block
      component = FormField.new
      output = component.call do |field|
        field.label { label_builder }
        field.control { input_builder }
      end

      expected_html = <<~HTML
        <div class="field">
          <label>Label Here</label>
          <div class="control">
            <input name="test_input" type="text" />
          </div>
        </div>
      HTML

      assert_html_equal expected_html, output
    end

    def test_renders_label_from_string
      component = FormField.new
      output = component.call do |field|
        field.label "Label from String"
        field.control { input_builder }
      end

      expected_html = <<~HTML
        <div class="field">
          <label class="label">Label from String</label>
          <div class="control">
            <input name="test_input" type="text" />
          </div>
        </div>
      HTML

      assert_html_equal expected_html, output
    end

    def test_skips_label_when_not_provided
      component = FormField.new
      output = component.call do |field|
        field.control { input_builder }
      end
      expected_html = <<~HTML
        <div class="field">
          <div class="control">
            <input name="test_input" type="text" />
          </div>
        </div>
      HTML

      assert_html_equal expected_html, output
    end

    def test_includes_help_text_when_provided
      component = FormField.new(help: "This is help text.")
      output = component.call do |field|
        field.label "Label Here"
        field.control { input_builder }
      end

      expected_html = <<~HTML
        <div class="field">
          <label class="label">Label Here</label>
          <div class="control">
            <input name="test_input" type="text" />
          </div>
          <p class="help">This is help text.</p>
        </div>
      HTML

      assert_html_equal expected_html, output
    end

    def test_icon_on_the_left
      component = FormField.new(icon_left: "fas fa-user")
      output = component.call do |field|
        field.control { input_builder }
      end
      expected_html = <<~HTML
        <div class="field">
          <div class="control has-icons-left">
            <input name="test_input" type="text" />
            <span class="icon is-small is-left">
              <i class="fas fa-user"></i>
            </span>
          </div>
        </div>
      HTML

      assert_html_equal expected_html, output
    end

    def test_icon_on_the_right
      component = FormField.new(icon_right: "fas fa-user")
      output = component.call do |field|
        field.control { input_builder }
      end
      expected_html = <<~HTML
        <div class="field">
          <div class="control has-icons-right">
            <input name="test_input" type="text" />
            <span class="icon is-small is-right">
              <i class="fas fa-user"></i>
            </span>
          </div>
        </div>
      HTML

      assert_html_equal expected_html, output
    end

    def test_icons_on_both_sides
      component = FormField.new(icon_left: "fas fa-user", icon_right: "fas fa-check")
      output = component.call do |field|
        field.control { input_builder }
      end
      expected_html = <<~HTML
        <div class="field">
          <div class="control has-icons-left has-icons-right">
            <input name="test_input" type="text" />
            <span class="icon is-small is-left">
              <i class="fas fa-user"></i>
            </span>
            <span class="icon is-small is-right">
              <i class="fas fa-check"></i>
            </span>
          </div>
        </div>
      HTML

      assert_html_equal expected_html, output
    end

    def test_column_true
      component = FormField.new(column: true)
      output = component.call do |field|
        field.label { label_builder }
        field.control { input_builder }
      end

      expected_html = <<~HTML
        <div class="field column">
          <label>Label Here</label>
          <div class="control">
            <input name="test_input" type="text" />
          </div>
        </div>
      HTML

      assert_html_equal expected_html, output
    end

    def test_column_with_size
      component = FormField.new(column: "two-thirds")
      output = component.call do |field|
        field.label { label_builder }
        field.control { input_builder }
      end

      expected_html = <<~HTML
        <div class="field column is-two-thirds">
          <label>Label Here</label>
          <div class="control">
            <input name="test_input" type="text" />
          </div>
        </div>
      HTML

      assert_html_equal expected_html, output
    end

    def test_column_with_breakpoint_sizes
      component = FormField.new(column: { mobile: "full", desktop: "half" })
      output = component.call do |field|
        field.label { label_builder }
        field.control { input_builder }
      end

      expected_html = <<~HTML
        <div class="field column is-full-mobile is-half-desktop">
          <label>Label Here</label>
          <div class="control">
            <input name="test_input" type="text" />
          </div>
        </div>
      HTML

      assert_html_equal expected_html, output
    end

    def test_grid_true
      component = FormField.new(grid: true)
      output = component.call do |field|
        field.label { label_builder }
        field.control { input_builder }
      end

      expected_html = <<~HTML
        <div class="field cell">
          <label>Label Here</label>
          <div class="control">
            <input name="test_input" type="text" />
          </div>
        </div>
      HTML

      assert_html_equal expected_html, output
    end

    def test_grid_with_size
      component = FormField.new(grid: "col-span-2")
      output = component.call do |field|
        field.label { label_builder }
        field.control { input_builder }
      end

      expected_html = <<~HTML
        <div class="field cell is-col-span-2">
          <label>Label Here</label>
          <div class="control">
            <input name="test_input" type="text" />
          </div>
        </div>
      HTML

      assert_html_equal expected_html, output
    end

    def test_with_no_label_control_block_is_implicit
      component = FormField.new(grid: "col-span-2")
      output = component.call do
        input_builder
      end

      assert_html_equal <<~HTML, output
        <div class="field cell is-col-span-2">
          <div class="control">
            <input name="test_input" type="text" />
          </div>
        </div>
      HTML
    end

    private

    def label_builder
      Label.call.extend(Phlex::SGML::SafeObject)
    end

    def input_builder
      Input.call.extend(Phlex::SGML::SafeObject)
    end
  end
end
