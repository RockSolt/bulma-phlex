# frozen_string_literal: true

module BulmaPhlex
  # Renders a dropdown menu for the [Bulma navbar](https://bulma.io/documentation/components/navbar/#dropdown-menu).
  #
  # Provides structured content for a navbar dropdown, including **headers**, **links**, and **dividers**.
  # Intended to be used inside a {BulmaPhlex::NavigationBar} block.
  #
  # ## Example
  #
  #     render BulmaPhlex::NavigationBar.new do |navbar|
  #       navbar.brand_item "My App", "/"
  #
  #       navbar.right do |menu|
  #         menu.dropdown "Account" do |dropdown|
  #           dropdown.header "User"
  #           dropdown.item "Profile", "/profile"
  #           dropdown.item "Settings", "/settings"
  #           dropdown.divider
  #           dropdown.item "Sign Out", "/logout"
  #         end
  #       end
  #     end
  class NavigationBarDropdown < BulmaPhlex::Base
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
