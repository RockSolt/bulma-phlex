# frozen_string_literal: true

require "test_helper"

module BulmaPhlex
  class MenuTest < Minitest::Test
    include TagOutputAssertions

    def test_menu
      component = Menu.new
      result = component.call do |menu|
        menu.label "General"
        menu.list do |list|
          list.item "Dashboard", href: "#dashboard"
          list.item "Customers", href: "#customers"
        end
      end

      assert_html_equal <<~HTML, result
        <aside class="menu">
          <p class="menu-label">General</p>
          <ul class="menu-list">
            <li><a href="#dashboard">Dashboard</a></li>
            <li><a href="#customers">Customers</a></li>
          </ul>
        </aside>
      HTML
    end

    def test_active_item
      component = Menu.new
      result = component.call do |menu|
        menu.label "General"
        menu.list do |list|
          list.item "Dashboard", href: "#dashboard", active: true
          list.item "Customers", href: "#customers"
        end
      end

      assert_html_equal <<~HTML, result
        <aside class="menu">
          <p class="menu-label">General</p>
          <ul class="menu-list">
            <li><a href="#dashboard" class="is-active">Dashboard</a></li>
            <li><a href="#customers">Customers</a></li>
          </ul>
        </aside>
      HTML
    end

    def test_expandable_item_with_nested_list
      component = Menu.new
      result = component.call do |menu|
        menu.label "General"
        menu.list do |list|
          list.item "Dashboard", href: "#dashboard"
          list.expandable_item("Customers", open: "true") do |nested|
            nested.item "Active Customers", href: "#active-customers"
            nested.item "Inactive Customers", href: "#inactive-customers"
          end
        end
      end

      assert_html_equal <<~HTML, result
        <aside class="menu">
          <p class="menu-label">General</p>
          <ul class="menu-list">
            <li><a href="#dashboard">Dashboard</a></li>
            <li>
              <details open="true">
                <summary class="menu-item is-clickable">Customers</summary>
                <ul class="menu-list">
                  <li><a href="#active-customers">Active Customers</a></li>
                  <li><a href="#inactive-customers">Inactive Customers</a></li>
                </ul>
              </details>
            </li>
          </ul>
        </aside>
      HTML
    end

    def test_expandable_item_with_nested_list_and_active_item
      component = Menu.new
      result = component.call do |menu|
        menu.label "General"
        menu.list do |list|
          list.item "Dashboard", href: "#dashboard"
          list.expandable_item("Customers", open: "true") do |nested|
            nested.item "Active Customers", href: "#active-customers", active: true
            nested.item "Inactive Customers", href: "#inactive-customers"
          end
        end
      end

      assert_html_equal <<~HTML, result
        <aside class="menu">
          <p class="menu-label">General</p>
          <ul class="menu-list">
            <li><a href="#dashboard">Dashboard</a></li>
            <li>
              <details open="true">
                <summary class="menu-item is-clickable">Customers</summary>
                <ul class="menu-list">
                  <li><a href="#active-customers" class="is-active">Active Customers</a></li>
                  <li><a href="#inactive-customers">Inactive Customers</a></li>
                </ul>
              </details>
            </li>
          </ul>
        </aside>
      HTML
    end

    def test_with_nested_list
      component = Menu.new
      result = component.call do |menu|
        menu.label "General"
        menu.list do |list|
          list.item "Dashboard", href: "#dashboard"
          list.item "Customers", href: "#customers" do |nested|
            nested.item "Active Customers", href: "#active-customers"
            nested.item "Inactive Customers", href: "#inactive-customers"
          end
        end
      end

      assert_html_equal <<~HTML, result
        <aside class="menu">
          <p class="menu-label">General</p>
          <ul class="menu-list">
            <li><a href="#dashboard">Dashboard</a></li>
            <li><a href="#customers">Customers</a>
              <ul class="menu-list">
                <li><a href="#active-customers">Active Customers</a></li>
                <li><a href="#inactive-customers">Inactive Customers</a></li>
              </ul>
            </li>
          </ul>
        </aside>
      HTML
    end

    def test_menu_with_additional_attributes
      component = Menu.new(id: "my-menu", class: "custom-class")
      result = component.call do |menu|
        menu.label "General"
        menu.list do |list|
          list.item "Dashboard", href: "#dashboard"
        end
      end

      assert_html_equal <<~HTML, result
        <aside id="my-menu" class="menu custom-class">
          <p class="menu-label">General</p>
          <ul class="menu-list">
            <li><a href="#dashboard">Dashboard</a></li>
          </ul>
        </aside>
      HTML
    end

    def test_additional_attributes_on_label
      component = Menu.new
      result = component.call do |menu|
        menu.label "General", class: "custom-label-class"
        menu.list do |list|
          list.item "Dashboard", href: "#dashboard"
        end
      end

      assert_html_equal <<~HTML, result
        <aside class="menu">
          <p class="menu-label custom-label-class">General</p>
          <ul class="menu-list">
            <li><a href="#dashboard">Dashboard</a></li>
          </ul>
        </aside>
      HTML
    end

    def test_additional_attributes_on_list
      component = Menu.new
      result = component.call do |menu|
        menu.label "General"
        menu.list(class: "custom-list-class", data: { controller: "menu" }) do |list|
          list.item "Dashboard", href: "#dashboard"
        end
      end

      assert_html_equal <<~HTML, result
        <aside class="menu">
          <p class="menu-label">General</p>
          <ul class="menu-list custom-list-class" data-controller="menu">
            <li><a href="#dashboard">Dashboard</a></li>
          </ul>
        </aside>
      HTML
    end

    def test_additional_attributes_on_item
      component = Menu.new
      result = component.call do |menu|
        menu.label "General"
        menu.list do |list|
          list.item "Dashboard", href: "#dashboard", class: "custom-item-class",
                                 data: { action: "click->menu#navigate" }
        end
      end

      assert_html_equal <<~HTML, result
        <aside class="menu">
          <p class="menu-label">General</p>
          <ul class="menu-list">
            <li><a href="#dashboard" class="custom-item-class" data-action="click->menu#navigate">Dashboard</a></li>
          </ul>
        </aside>
      HTML
    end

    def test_additional_attributes_on_item_and_list_item
      component = Menu.new
      result = component.call do |menu|
        menu.label "General"
        menu.list do |list|
          list.item "Dashboard", href: "#dashboard",
                                 class: "custom-item-class",
                                 data: { action: "click->menu#navigate" },
                                 li_attributes: { class: "custom-li-class", data: { controller: "list-item" } }
        end
      end

      assert_html_equal <<~HTML, result
        <aside class="menu">
          <p class="menu-label">General</p>
          <ul class="menu-list">
            <li class="custom-li-class" data-controller="list-item">
              <a href="#dashboard" class="custom-item-class" data-action="click->menu#navigate">Dashboard</a>
            </li>
          </ul>
        </aside>
      HTML
    end
  end
end
