# frozen_string_literal: true

require "test_helper"

module BulmaPhlex
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
        <div class="navbar-dropdown">
          <div class="navbar-item has-text-weight-semibold">User</div>
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

      assert_html_includes result, '<div class="navbar-item has-text-weight-semibold">Section 1</div>'
      assert_html_includes result, '<hr class="navbar-divider">'
      assert_html_includes result, '<div class="navbar-item has-text-weight-semibold">Section 2</div>'
    end

    def test_renders_optional_divider_on_headers
      component = BulmaPhlex::NavigationBarDropdown.new

      result = component.call do |dropdown|
        dropdown.header("Section 1")
        dropdown.item("Item 1", "/item1")
        dropdown.header("Section 2", divider: true)
        dropdown.item("Item 2", "/item2")
      end

      assert_html_equal <<~HTML, result
        <div class="navbar-dropdown">
          <div class="navbar-item has-text-weight-semibold">Section 1</div>
          <a class="navbar-item" href="/item1">Item 1</a>
          <hr class="navbar-divider">
          <div class="navbar-item has-text-weight-semibold">Section 2</div>
          <a class="navbar-item" href="/item2">Item 2</a>
        </div>
      HTML
    end

    def test_with_right_aligned_dropdown
      component = BulmaPhlex::NavigationBarDropdown.new(right: true)

      result = component.call do |dropdown|
        dropdown.header("Section 1")
        dropdown.item("Item 1", "/item1")
      end

      assert_html_includes result, '<div class="navbar-dropdown is-right">'
    end

    def test_with_boxed_dropdown
      component = BulmaPhlex::NavigationBarDropdown.new(boxed: true)

      result = component.call do |dropdown|
        dropdown.header("Section 1")
        dropdown.item("Item 1", "/item1")
      end

      assert_html_includes result, '<div class="navbar-dropdown is-boxed">'
    end

    def test_with_html_attributes_on_dropdown
      component = BulmaPhlex::NavigationBarDropdown.new(data: { foo: "bar" }, id: "my-dropdown")

      result = component.call do |dropdown|
        dropdown.header("Section 1")
        dropdown.item("Item 1", "/item1")
      end

      assert_html_includes result, '<div class="navbar-dropdown" data-foo="bar" id="my-dropdown">'
    end

    def test_header_with_html_attributes
      component = BulmaPhlex::NavigationBarDropdown.new

      result = component.call do |dropdown|
        dropdown.header("Section 1", class: "custom-header")
        dropdown.header("Section 2", data: { foo: "bar" })
      end

      assert_html_includes result, '<div class="navbar-item has-text-weight-semibold custom-header">Section 1</div>'
      assert_html_includes result, '<div class="navbar-item has-text-weight-semibold" data-foo="bar">Section 2</div>'
    end

    def test_item_with_html_attributes
      component = BulmaPhlex::NavigationBarDropdown.new

      result = component.call do |dropdown|
        dropdown.item("Item 1", "/item1", class: "custom-class")
        dropdown.item("Item 2", "/item2", data: { foo: "bar" })
      end

      assert_html_includes result, '<a class="navbar-item custom-class" href="/item1">Item 1</a>'
      assert_html_includes result, '<a class="navbar-item" href="/item2" data-foo="bar">Item 2</a>'
    end

    def test_divider_with_html_attributes
      component = BulmaPhlex::NavigationBarDropdown.new

      result = component.call do |dropdown|
        dropdown.divider(class: "custom-divider")
        dropdown.divider(data: { foo: "bar" })
      end

      assert_html_includes result, '<hr class="navbar-divider custom-divider">'
      assert_html_includes result, '<hr class="navbar-divider" data-foo="bar">'
    end
  end
end
