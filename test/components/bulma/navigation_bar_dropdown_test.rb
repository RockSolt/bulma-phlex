# frozen_string_literal: true

require "test_helper"

module Components
  module Bulma
    class NavigationBarDropdownTest < Minitest::Test
      include TagOutputAssertions

      def test_renders_navigation_bar_dropdown
        component = BulmaPhlex::NavigationBarDropdown.new

        result = component.call do |dropdown|
          dropdown.header("User")
          dropdown.item("Profile", "/profile")
          dropdown.divider
          dropdown.item("Sign Out", "/logout")
        end

        expected_html = <<~HTML
          <div class="navbar-dropdown is-right">
            <div class="navbar-item header has-text-weight-medium">User</div>
            <a class="navbar-item" href="/profile">Profile</a>
            <hr class="navbar-divider">
            <a class="navbar-item" href="/logout">Sign Out</a>
          </div>
        HTML

        assert_html_equal expected_html, result
      end

      def test_renders_dropdown_with_multiple_items
        component = BulmaPhlex::NavigationBarDropdown.new

        result = component.call do |dropdown|
          dropdown.item("Item 1", "/item1")
          dropdown.item("Item 2", "/item2")
          dropdown.item("Item 3", "/item3")
        end

        assert_html_includes result, '<a class="navbar-item" href="/item1">Item 1</a>'
        assert_html_includes result, '<a class="navbar-item" href="/item2">Item 2</a>'
        assert_html_includes result, '<a class="navbar-item" href="/item3">Item 3</a>'
      end

      def test_renders_with_header_and_divider
        component = BulmaPhlex::NavigationBarDropdown.new

        result = component.call do |dropdown|
          dropdown.header("Section 1")
          dropdown.item("Item 1", "/item1")
          dropdown.divider
          dropdown.header("Section 2")
          dropdown.item("Item 2", "/item2")
        end

        assert_html_includes result, '<div class="navbar-item header has-text-weight-medium">Section 1</div>'
        assert_html_includes result, '<hr class="navbar-divider">'
        assert_html_includes result, '<div class="navbar-item header has-text-weight-medium">Section 2</div>'
      end
    end
  end
end
