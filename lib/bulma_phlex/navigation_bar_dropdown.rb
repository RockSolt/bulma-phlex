# frozen_string_literal: true

module BulmaPhlex
  # Renders a dropdown menu for the [Bulma navbar](https://bulma.io/documentation/components/navbar/#dropdown-menu).
  #
  # Provides structured content for a navbar dropdown, including **headers**, **links**, and **dividers**. Pass boolean
  # flags `right` or `boxed` to the constructor to customize the dropdown. This component is intended to be used inside
  # a {BulmaPhlex::NavigationBar} block.
  #
  # The constructor and each of the three methods (`header`, `item`, and `divider`) can accept additional HTML
  # attributes.
  #
  # ## Example
  #
  #     render BulmaPhlex::NavigationBar.new(right: true) do |navbar|
  #       navbar.brand_item "My App", "/"
  #
  #       navbar.right do |menu|
  #         menu.dropdown "Account" do |dropdown|
  #           dropdown.header "User"
  #           dropdown.item "Profile", "/profile"
  #           dropdown.item "Settings", "/settings"
  #           dropdown.divider
  #           dropdown.item "Sign Out", "/logout", data: { turbo_prefetch: "false" }
  #         end
  #       end
  #     end
  class NavigationBarDropdown < BulmaPhlex::Base
    # **Parameters**
    #
    # - `right` — If `true`, aligns the dropdown to the right side of the navbar
    # - `boxed` — If `true`, applies the Bulma `is-boxed` style to the dropdown
    # - `**html_attributes` — Additional HTML attributes for the dropdown container
    def self.new(right: false, boxed: false, **html_attributes)
      super
    end

    def initialize(right: false, boxed: false, **html_attributes)
      @right = right
      @boxed = boxed
      @html_attributes = html_attributes
    end

    def view_template(&)
      div(**mix({ class: navbar_dropdown_classes }, @html_attributes), &)
    end

    # Adds a non-clickable header item to the dropdown menu. Optionally add a divider before the header with
    # the `divder: true` parameter.
    def header(label, divider: false, **html_attributes)
      self.divider if divider

      attributes = mix({ class: "navbar-item has-text-weight-semibold" }, html_attributes)
      div(**attributes) { label }
    end

    def item(label, path, **html_attributes)
      attributes = mix({ class: "navbar-item", href: path }, html_attributes)
      a(**attributes) { label }
    end

    def divider(**html_attributes)
      attributes = mix({ class: "navbar-divider" }, html_attributes)
      hr(**attributes)
    end

    private

    def navbar_dropdown_classes
      classes = ["navbar-dropdown"]
      classes << "is-right" if @right
      classes << "is-boxed" if @boxed
      classes.join(" ")
    end
  end
end
