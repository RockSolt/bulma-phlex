# frozen_string_literal: true

module BulmaPhlex
  # Renders the [Bulma navbar](https://bulma.io/documentation/components/navbar/) component.
  #
  # A responsive navigation header with support for **branding**, left/right **navigation links**,
  # and **dropdown menus**, automatically collapsing on mobile devices. Supports **color**,
  # **transparency**, **spacing**, and **shadow** options. Uses the Stimulus controller
  # `bulma-phlex--navigation-bar` (available via the `bulma-phlex-rails` gem) for mobile menu toggling.
  #
  # ## Example
  #
  #     render BulmaPhlex::NavigationBar.new do |navbar|
  #       navbar.brand do
  #         a(href: "/", class: "navbar-item") { "My App" }
  #       end
  #
  #       navbar.left do
  #         a(href: "/", class: "navbar-item") { "Home" }
  #         a(href: "/products", class: "navbar-item") { "Products" }
  #       end
  #
  #       navbar.right do
  #         a(href: "/about", class: "navbar-item") { "About" }
  #
  #         div(class: "navbar-item has-dropdown is-hoverable") do
  #           a(class: "navbar-link") { "Account" }
  #           render BulmaPhlex::NavigationBarDropdown.new do |dropdown|
  #             dropdown.item "Sign In", "/login"
  #             dropdown.item "Register", "/register"
  #           end
  #         end
  #       end
  #     end
  #
  class NavigationBar < BulmaPhlex::Base
    # **Parameters**
    # - `container` — If `true`, wraps the navbar content in a `.container` for fixed-width layout. Can also
    #   be a string or symbol to specify a custom container class
    # - `color` — Sets the navbar color (e.g., `"primary"`, `"light"`, `"dark"`)
    # - `transparent` — If `true`, makes the navbar transparent
    # - `spaced` — If `true`, adds spacing to the navbar
    # - `shadow` — If `true`, adds a shadow to the navbar
    # - `**html_attributes` — Additional HTML attributes for the `<nav>` element
    def self.new(container: false,
                 color: nil,
                 transparent: false,
                 spaced: false,
                 shadow: false,
                 **html_attributes)
      super
    end

    def initialize(container: false,
                   color: nil,
                   transparent: false,
                   spaced: false,
                   shadow: false,
                   **html_attributes)
      @container = container
      @color = color
      @transparent = transparent
      @spaced = spaced
      @shadow = shadow
      @html_attributes = html_attributes

      @brand = []
      @left = []
      @right = []
    end

    def view_template(&)
      vanish(&)

      nav(**mix(nav_attributes, @html_attributes)) do
        optional_container do
          div(class: "navbar-brand") do
            @brand.each(&:call)

            a(class: "navbar-burger",
              role: "button",
              aria_label: "menu",
              aria_expanded: "false",
              data: {
                action: "bulma-phlex--navigation-bar#toggle",
                "bulma-phlex--navigation-bar-target": "burger"
              }) do
              4.times { span(aria_hidden: "true") }
            end
          end

          div(class: "navbar-menu",
              data: { "bulma-phlex--navigation-bar-target": "menu" }) do
            div(class: "navbar-start") do
              @left.each(&:call)
            end

            div(class: "navbar-end") do
              @right.each(&:call)
            end
          end
        end
      end
    end

    # Sets the brand area of the navbar (typically a logo or site name).
    #
    # Expects a block that renders the brand content. Can be called multiple times.
    def brand(&block)
      @brand << block
    end

    # Adds content to the left side of the navbar menu. Can be called multiple times.
    #
    # Expects a block that renders navbar items (e.g. `<a class="navbar-item">`).
    def left(&block)
      @left << block
    end

    # Adds content to the right side of the navbar menu. Can be called multiple times.
    #
    # Expects a block that renders navbar items (e.g. `<a class="navbar-item">`).
    def right(&block)
      @right << block
    end

    private

    def nav_attributes
      { class: nav_classes,
        role: "navigation",
        aria_label: "main navigation",
        data: { controller: "bulma-phlex--navigation-bar" } }
    end

    def nav_classes
      classes = ["navbar"]
      classes << "is-#{@color}" if @color
      classes << "is-transparent" if @transparent
      classes << "is-spaced" if @spaced
      classes << "has-shadow" if @shadow
      classes
    end

    def optional_container(&)
      if @container
        constraint = @container if @container.is_a?(String) || @container.is_a?(Symbol)
        div(class: "container #{constraint}".rstrip, &)
      else
        yield
      end
    end
  end
end
