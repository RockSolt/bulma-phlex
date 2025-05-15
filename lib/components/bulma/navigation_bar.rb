module Components
  module Bulma
    # Navigation bar component for site navigation
    #
    # This component implements the [Bulma navbar](https://bulma.io/documentation/components/navbar/)
    # interface. It provides a responsive navigation header with support for branding, navigation
    # links, and dropdown menus, automatically collapsing on mobile devices.
    #
    # ## Example
    #
    # ```ruby
    # render Components::Bulma::NavigationBar.new do |navbar|
    #   navbar.brand do
    #     a(href: "/", class: "navbar-item") { "My App" }
    #   end
    #
    #   navbar.left do
    #     a(href: "/", class: "navbar-item") { "Home" }
    #     a(href: "/products", class: "navbar-item") { "Products" }
    #   end
    #
    #   navbar.right do
    #     a(href: "/about", class: "navbar-item") { "About" }
    #
    #     div(class: "navbar-item has-dropdown is-hoverable") do
    #       a(class: "navbar-link") { "Account" }
    #       render Components::Bulma::NavigationBarDropdown do |dropdown|
    #         dropdown.item "Sign In", "/login"
    #         dropdown.item "Register", "/register"
    #       end
    #     end
    #   end
    # end
    # ```
    #
    class NavigationBar < Components::Bulma::Base
      def initialize
        @brand = []
        @left = []
        @right = []
      end

      def view_template(&)
        vanish(&)

        nav(class: "navbar is-light block",
            role: "navigation",
            aria_label: "main navigation",
            data: { controller: "bulma--navigation-bar" }) do
          div(class: "container") do
            div(class: "navbar-brand") do
              @brand.each(&:call)

              a(class: "navbar-burger",
                role: "button",
                aria_label: "menu",
                aria_expanded: "false",
                data: {
                  action: "bulma--navigation-bar#toggle",
                  "bulma--navigation-bar-target": "burger"
                }) do
                4.times { span(aria_hidden: "true") }
              end
            end

            div(class: "navbar-menu",
                data: { "bulma--navigation-bar-target": "menu" }) do
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

      def brand(&block)
        @brand << block
      end

      def left(&block)
        @left << block
      end

      def right(&block)
        @right << block
      end
    end
  end
end
