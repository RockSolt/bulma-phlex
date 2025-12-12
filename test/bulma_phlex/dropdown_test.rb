# frozen_string_literal: true

require "test_helper"

module BulmaPhlex
  class DropdownTest < Minitest::Test
    include TagOutputAssertions

    def test_renders_basic_dropdown
      component = BulmaPhlex::Dropdown.new("Menu")

      result = component.call

      expected_html = <<~HTML
        <div class="dropdown" data-controller="bulma-phlex--dropdown">
          <div class="dropdown-trigger">
            <button class="button" aria-haspopup="true" aria-controls="dropdown-menu" data-action="bulma-phlex--dropdown#toggle">
              <span>Menu</span>
              <span class="icon is-small"><i class="fas fa-angle-down" aria-hidden="true"></i></span>
            </button>
          </div>
          <div class="dropdown-menu" id="dropdown-menu" role="menu">
            <div class="dropdown-content"></div>
          </div>
        </div>
      HTML

      assert_html_equal expected_html, result
    end

    def test_renders_dropdown_with_links_and_items
      component = BulmaPhlex::Dropdown.new("Menu")

      result = component.call do |dropdown|
        dropdown.link "Profile", "/profile"
        dropdown.divider
        dropdown.item "Just text"
      end

      expected_html = <<~HTML
        <div class="dropdown" data-controller="bulma-phlex--dropdown">
          <div class="dropdown-trigger">
            <button class="button" aria-haspopup="true" aria-controls="dropdown-menu" data-action="bulma-phlex--dropdown#toggle">
              <span>Menu</span>
              <span class="icon is-small"><i class="fas fa-angle-down" aria-hidden="true"></i></span>
            </button>
          </div>
          <div class="dropdown-menu" id="dropdown-menu" role="menu">
            <div class="dropdown-content">
              <a class="dropdown-item" href="/profile">Profile</a>
              <hr class="dropdown-divider">
              <div class="dropdown-item">Just text</div>
            </div>
          </div>
        </div>
      HTML

      assert_html_equal expected_html, result
    end

    def test_renders_dropdown_with_block_item
      component = BulmaPhlex::Dropdown.new("Menu")

      result = component.call do |dropdown|
        dropdown.item do |context|
          context.span(class: "custom") { "Block Item" }
        end
      end

      assert_html_includes result, '<span class="custom">Block Item</span>'
      assert_includes result, "dropdown-item"
    end

    def test_hoverable_dropdown
      component = BulmaPhlex::Dropdown.new("Menu", click: false)

      result = component.call

      assert_includes result, "is-hoverable"
    end

    def test_alignment_right
      component = BulmaPhlex::Dropdown.new("Menu", alignment: :right)

      result = component.call

      assert_includes result, "is-right"
    end

    def test_alignment_up
      component = BulmaPhlex::Dropdown.new("Menu", alignment: :up)

      result = component.call

      assert_includes result, "is-up"
    end

    def test_custom_icon
      component = BulmaPhlex::Dropdown.new("Menu", icon: "fas fa-caret-down")

      result = component.call

      assert_includes result, "fas fa-caret-down"
    end

    def test_dropdown_link_escapes_label
      component = BulmaPhlex::Dropdown.new("Menu")

      result = component.call do |dropdown|
        dropdown.link "<b>Unsafe</b>", "/unsafe"
      end

      refute_includes result, "<b>Unsafe</b>"
      assert_includes result, "&lt;b&gt;Unsafe&lt;/b&gt;"
    end

    def test_dropdown_with_custom_label_and_icon
      component = BulmaPhlex::Dropdown.new("Actions", icon: "fas fa-ellipsis-v")

      result = component.call

      assert_includes result, "Actions"
      assert_includes result, "fas fa-ellipsis-v"
    end

    def test_dropdown_with_string_alignment
      component = BulmaPhlex::Dropdown.new("Menu", alignment: "right")

      result = component.call

      assert_includes result, "is-right"
    end
  end
end
