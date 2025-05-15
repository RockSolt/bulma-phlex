# frozen_string_literal: true

require "test_helper"

# The `instance_eval` call is needed to get the block to execute in the context of the component. That is not necessary
# in standard usage, but is needed in the test to simulate the component's behavior.
module Components
  module Bulma
    class NavigationBarTest < Minitest::Test
      include TagOutputAssertions

      def test_renders_navigation_bar_with_brand
        component = Components::Bulma::NavigationBar.new

        result = component.call do |navbar|
          navbar.brand do
            navbar.instance_eval { a(href: "/", class: "navbar-item") { "Brand Name" } }
          end
        end

        # Format for readability
        formatted = format_html(result)

        # Check for key elements
        assert_html_includes formatted, '<div class="navbar-brand">'
        assert_html_includes formatted, '<a href="/" class="navbar-item">Brand Name</a>'
        assert_html_includes formatted, '<a class="navbar-burger"'
      end

      def test_renders_with_left_and_right_menus
        component = Components::Bulma::NavigationBar.new

        result = component.call do |navbar|
          navbar.brand do
            navbar.instance_eval { a(href: "/", class: "navbar-item") { "Brand" } }
          end

          navbar.left do
            navbar.instance_eval { a(href: "/home", class: "navbar-item") { "Home" } }
          end

          navbar.right do
            navbar.instance_eval { a(href: "/login", class: "navbar-item") { "Login" } }
          end
        end

        expected_structure = <<~HTML
          <nav class="navbar is-light block" role="navigation" aria-label="main navigation" data-controller="bulma--navigation-bar">
            <div class="container">
              <div class="navbar-brand">
                <a href="/" class="navbar-item">Brand</a>
                <a class="navbar-burger" role="button" aria-label="menu" aria-expanded="false" data-action="bulma--navigation-bar#toggle" data-bulma--navigation-bar-target="burger">
                  <span aria-hidden="true"></span>
                  <span aria-hidden="true"></span>
                  <span aria-hidden="true"></span>
                  <span aria-hidden="true"></span>
                </a>
              </div>
              <div class="navbar-menu" data-bulma--navigation-bar-target="menu">
                <div class="navbar-start">
                  <a href="/home" class="navbar-item">Home</a>
                </div>
                <div class="navbar-end">
                  <a href="/login" class="navbar-item">Login</a>
                </div>
              </div>
            </div>
          </nav>
        HTML

        assert_dom_equal expected_structure, result
      end
    end
  end
end
