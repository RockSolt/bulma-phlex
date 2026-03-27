# frozen_string_literal: true

module Playground
  module Sections
    class NavigationBar < Phlex::HTML
      def view_template
        # ── NavigationBar ─────────────────────────────────────────────────────────

        h2(class: "title is-4") { "Navigation Bar" }

        h3(class: "label") { "Basic Navbar" }
        div(class: "mb-5") do
          render BulmaPhlex::NavigationBar.new do |nav|
            nav.brand do
              a(class: "navbar-item", href: "#") { strong { plain "Brand" } }
            end

            nav.left do
              a(class: "navbar-item", href: "#") { "Home" }
              a(class: "navbar-item", href: "#") { "Docs" }
              a(class: "navbar-item", href: "#") { "About" }
            end

            nav.right do
              div(class: "navbar-item") do
                render BulmaPhlex::Button.new(color: "primary", size: "small") { "Sign up" }
              end
            end
          end
        end

        h3(class: "label") { "With Dropdown & Icons" }
        div(class: "mb-5") do
          render BulmaPhlex::NavigationBar.new do |nav|
            nav.brand do
              a(class: "navbar-item", href: "#") do
                span(class: "icon-text") do
                  span(class: "icon") { i(class: "fas fa-feather") }
                  span { plain "BulmaPhlex" }
                end
              end
            end

            nav.left do
              a(class: "navbar-item", href: "#") { "Overview" }
              a(class: "navbar-item", href: "#") { "Components" }
              div(class: "navbar-item has-dropdown is-hoverable") do
                a(class: "navbar-link") { "More" }
                render BulmaPhlex::NavigationBarDropdown.new do |dd|
                  dd.item "Blog", "#"
                  dd.item "Community", "#"
                  dd.divider
                  dd.item "Changelog", "#"
                end
              end
            end

            nav.right do
              a(href: "#", class: "navbar-item") do
                span(class: "icon") { i(class: "fas fa-bell") }
              end
              div(class: "navbar-item") do
                render BulmaPhlex::Button.new(outlined: true, size: "small") { "Log in" }
              end
            end
          end
        end

        h3(class: "label") { "Color Variants" }
        div(class: "mb-5") do
          render BulmaPhlex::NavigationBar.new(color: "primary") do |nav|
            nav.brand do
              a(class: "navbar-item", href: "#") { plain "Brand" }
            end

            nav.left do
              a(class: "navbar-item", href: "#") { "Left" }
            end

            nav.right do
              div(class: "navbar-item") do
                render BulmaPhlex::Button.new(color: "light", outlined: true) { "Help" }
              end
            end
          end
        end

        h3(class: "label") { "With Shadow & Spaced" }
        div(class: "mb-5") do
          render BulmaPhlex::NavigationBar.new(shadow: true, spaced: true) do |nav|
            nav.brand do
              a(class: "navbar-item", href: "#") { plain "Shadowed & Spaced" }
            end

            nav.left do
              a(class: "navbar-item", href: "#") { "Home" }
              a(class: "navbar-item", href: "#") { "About" }
            end
          end
        end

        h3(class: "label") { "With Container" }
        div(class: "mb-5") do
          render BulmaPhlex::NavigationBar.new(container: true) do |nav|
            nav.brand do
              a(class: "navbar-item", href: "#") { plain "Contained Brand" }
            end

            nav.left do
              a(class: "navbar-item", href: "#") { "Home" }
              a(class: "navbar-item", href: "#") { "Examples" }
            end

            nav.right do
              div(class: "navbar-item") do
                render BulmaPhlex::Button.new(size: "small") { "Contact" }
              end
            end
          end
        end

        # ── NavigationBar Dropdown ────────────────────────────────────────────────

        h2(class: "title is-4 mt-6") { "Navigation Bar Dropdown" }

        h3(class: "label") { "Basic Dropdown (within a navbar)" }
        div(class: "mb-5") do
          render BulmaPhlex::NavigationBar.new do |nav|
            nav.brand do
              a(class: "navbar-item", href: "#") { plain "Brand" }
            end

            nav.right do
              div(class: "navbar-item has-dropdown is-hoverable") do
                a(class: "navbar-link") { "Account" }
                render BulmaPhlex::NavigationBarDropdown.new do |dd|
                  dd.item "Profile", "#"
                  dd.item "Settings", "#"
                  dd.divider
                  dd.item "Sign out", "#"
                end
              end
            end
          end
        end

        h3(class: "label") { "Dropdown with Header" }
        div(class: "mb-5") do
          render BulmaPhlex::NavigationBar.new do |nav|
            nav.brand do
              a(class: "navbar-item", href: "#") { plain "Brand" }
            end

            nav.right do
              div(class: "navbar-item has-dropdown is-hoverable") do
                a(class: "navbar-link") { "User Menu" }
                render BulmaPhlex::NavigationBarDropdown.new do |dd|
                  dd.header "Navigation"
                  dd.item "Dashboard", "#"
                  dd.item "Billing", "#"
                  dd.divider
                  dd.item "Preferences", "#"
                end
              end
            end
          end
        end

        h3(class: "label") { "Multiple Dropdowns" }
        div(class: "mb-5") do
          render BulmaPhlex::NavigationBar.new do |nav|
            nav.brand do
              a(class: "navbar-item", href: "#") { plain "Brand" }
            end

            nav.left do
              a(class: "navbar-item", href: "#") { "Home" }
              div(class: "navbar-item has-dropdown is-hoverable") do
                a(class: "navbar-link") { "Products" }
                render BulmaPhlex::NavigationBarDropdown.new do |dd|
                  dd.header "Categories"
                  dd.item "Electronics", "#"
                  dd.item "Clothing", "#"
                  dd.item "Books", "#"
                end
              end
              div(class: "navbar-item has-dropdown is-hoverable") do
                a(class: "navbar-link") { "Support" }
                render BulmaPhlex::NavigationBarDropdown.new do |dd|
                  dd.item "Documentation", "#"
                  dd.item "Community", "#"
                  dd.divider
                  dd.item "Contact Us", "#"
                end
              end
            end

            nav.right do
              div(class: "navbar-item has-dropdown is-hoverable") do
                a(class: "navbar-link") { "Account" }
                render BulmaPhlex::NavigationBarDropdown.new do |dd|
                  dd.header "Signed in as user@example.com"
                  dd.item "Profile", "#"
                  dd.item "Settings", "#"
                  dd.divider
                  dd.item "Sign out", "#"
                end
              end
            end
          end
        end
      end
    end
  end
end
