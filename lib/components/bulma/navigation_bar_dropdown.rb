# frozen_string_literal: true

module Components
  module Bulma
    # Dropdown component for the Bulma navigation bar
    #
    # This component implements the dropdown portion of the [Bulma navbar](https://bulma.io/documentation/components/navbar/#dropdown-menu).
    # It provides a structured way to add dropdown menus to a navigation bar with headers, items, and dividers.
    #
    # ## Example
    #
    # ```ruby
    # render Components::Bulma::NavigationBar.new do |navbar|
    #   navbar.brand_item "My App", "/"
    #
    #   navbar.right do |menu|
    #     menu.dropdown "Account" do |dropdown|
    #       dropdown.header "User"
    #       dropdown.item "Profile", "/profile"
    #       dropdown.item "Settings", "/settings"
    #       dropdown.divider
    #       dropdown.item "Sign Out", "/logout"
    #     end
    #   end
    # end
    # ```
    #
    class NavigationBarDropdown < Components::Bulma::Base
      def view_template(&)
        div(class: "navbar-dropdown is-right", &)
      end

      def header(label)
        div(class: "navbar-item header has-text-weight-medium") { label }
      end

      def item(label, path)
        a(class: "navbar-item", href: path) { label }
      end

      def divider
        hr(class: "navbar-divider")
      end
    end
  end
end
