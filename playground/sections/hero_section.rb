# frozen_string_literal: true

module Playground
  module Sections
    class Hero < Phlex::HTML
      def view_template
        h2(class: "title is-4") { "Hero" }

        h3(class: "label") { "Basic (colored, large)" }
        div(class: "mb-5") do
          # Simplest usage: pass title and subtitle as constructor params — no block needed.
          render BulmaPhlex::Hero.new(
            title: "Primary Hero",
            subtitle: "A simple primary hero section",
            color: "primary",
            size: "large"
          )
        end

        h3(class: "label") { "Medium Hero with custom body content" }
        div(class: "mb-5") do
          # Pass a block and call hero.body to render arbitrary HTML inside the hero-body section.
          render BulmaPhlex::Hero.new(size: "medium", color: "info") do |hero|
            hero.body do
              div(class: "container") do
                div(class: "columns") do
                  div(class: "column is-two-thirds") do
                    h1(class: "title") { plain "Informational hero" }
                    p { plain "Use the hero body to place arbitrary page content like headers, callouts, or forms." }
                  end
                  div(class: "column") do
                    div(class: "box") { plain "Aside content" }
                  end
                end
              end
            end
          end
        end

        h3(class: "label") { "Hero with head, body, and foot" }
        div(class: "mb-5") do
          # Use head / body / foot to populate each Bulma hero region:
          #   hero-head → typically a navbar / branding bar
          #   hero-body → main content area
          #   hero-foot → bottom tabs or actions
          # Each method accepts a block — positional arguments are not supported.
          render BulmaPhlex::Hero.new(color: "warning", size: "medium") do |hero|
            hero.head do
              nav(class: "navbar") do
                div(class: "navbar-brand") do
                  span(class: "navbar-item title is-5") { plain "My Site" }
                end
              end
            end
            hero.body do
              div(class: "container") do
                h1(class: "title") { plain "Hero With Footer" }
                p(class: "subtitle") { plain "Footer demonstrates the hero-foot area." }
              end
            end
            hero.foot do
              nav(class: "level") do
                div(class: "level-left") do
                  a(href: "#", class: "level-item") { plain "Left action" }
                end
                div(class: "level-right") do
                  a(href: "#", class: "level-item") { plain "Right action" }
                end
              end
            end
          end
        end

        h3(class: "label") { "Full-height hero with additional HTML attributes" }
        div(class: "mb-5") do
          # Use size: "fullheight" for the built-in Bulma fullheight modifier.
          # Any extra keyword arguments are treated as HTML attributes and merged
          # onto the <section> element — use class: to append additional CSS classes.
          render BulmaPhlex::Hero.new(color: "dark", size: "fullheight", class: "my-custom-section") do |hero|
            hero.body do
              div(class: "container has-text-centered") do
                h1(class: "title has-text-white") { plain "Full height hero" }
                p(class: "subtitle has-text-light") { plain "Useful for landing pages and immersive intro sections." }
                div(class: "mt-4") do
                  render BulmaPhlex::Button.new(color: "primary") { "Get started" }
                  render BulmaPhlex::Button.new(color: "light", outlined: true) { "Learn more" }
                end
              end
            end
          end
        end
      end
    end
  end
end
