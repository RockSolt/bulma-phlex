# frozen_string_literal: true

module Playground
  module Sections
    class Dropdown < Phlex::HTML
      def view_template
        h2(class: "title is-4") { "Dropdown" }

        h3(class: "label") { "Hover (no JavaScript)" }
        div(class: "mb-5") do
          render BulmaPhlex::Dropdown.new("Hover Menu", click: false) do |d|
            d.link "View Profile", "#"
            d.link "Settings", "#"
            d.divider
            d.item { plain "This is a plain text item." }
            d.item do
              div(class: "has-text-weight-bold") { plain "A bold custom item" }
            end
          end
        end

        h3(class: "label") { "Click (static rendering — Stimulus disabled in playground)" }
        div(class: "mb-5") do
          render BulmaPhlex::Dropdown.new("Click Menu", click: "bulma-phlex--dropdown") do |d|
            d.link "Notifications", "#"
            d.link "Messages", "#"
            d.link "Profile", "#"
            d.divider
            d.item do
              span(class: "icon-text") do
                span(class: "icon") { i(class: "fas fa-user") }
                span { plain "Signed in as user@example.com" }
              end
            end
          end
        end

        h3(class: "label") { "Aligned & Icon" }
        div(class: "mb-5") do
          render BulmaPhlex::Dropdown.new("More", click: false, alignment: "right", icon: "fas fa-ellipsis-v") do |d|
            d.link "Documentation", "https://bulma.io"
            d.link "Source", "#"
            d.divider
            d.item { plain "A final action" }
          end
        end

        h3(class: "label") { "Custom Item Blocks" }
        div(class: "mb-5") do
          render BulmaPhlex::Dropdown.new("Custom Items", click: false) do |d|
            d.item do
              div do
                p { plain "Block item with multiple elements:" }
                p do
                  span(class: "tag is-info") { plain "Info" }
                  span(class: "ml-2") { plain "and some description." }
                end
              end
            end

            d.item do
              a(href: "#", class: "has-text-primary") { plain "A link-styled custom item" }
            end
          end
        end
      end
    end
  end
end
