# frozen_string_literal: true

module Playground
  module Sections
    class Card < Phlex::HTML
      def view_template
        h2(class: "title is-4") { "Card" }

        h3(class: "label") { "Basic" }
        div(class: "mb-5") do
          render BulmaPhlex::Card.new do |card|
            card.head("Card Title")
            card.content do
              plain "This is a simple card with a header and body content. Use cards to group related information."
            end
          end
        end

        h3(class: "label") { "With Footer Links" }
        div(class: "mb-5") do
          render BulmaPhlex::Card.new do |card|
            card.head("Card with Footer")
            card.content do
              plain "Cards can include a footer with one or more link items."
            end
            card.footer_link("View", "#", icon: "fas fa-eye")
            card.footer_link("Edit", "#", icon: "fas fa-edit", class: "has-text-primary")
            card.footer_link("Delete", "#", icon: "fas fa-trash", class: "has-text-danger")
          end
        end

        h3(class: "label") { "Custom Footer Item" }
        div(class: "mb-5") do
          render BulmaPhlex::Card.new do |card|
            card.head("Custom Footer")
            card.content do
              p(class: "content") do
                span do
                  "You can delegate full control of a footer item to a block. The top element must" \
                    "include the "
                end
                code { "card-footer-item" }
                span { " class." }
              end
            end
            card.footer_item do
              a(class: "card-footer-item has-text-weight-bold", href: "#") { "Custom Action" }
            end
            card.footer_link("Standard Link", "#")
          end
        end

        h3(class: "label") { "Header with Extra Classes" }
        div(class: "mb-5") do
          render BulmaPhlex::Card.new do |card|
            card.head("Card Title", classes: "has-background-light")
            card.content do
              plain "Header classes allow you to style the card header differently."
            end
            card.footer_link("OK", "#", class: "has-text-success")
          end
        end
      end
    end
  end
end
