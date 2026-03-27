# frozen_string_literal: true

module Playground
  module Sections
    class Level < Phlex::HTML
      def view_template
        h2(class: "title is-4") { "Level" }

        h3(class: "label") { "Basic Level" }
        div(class: "mb-5") do
          render BulmaPhlex::Level.new do |level|
            level.left do
              strong { "Left item" }
            end

            level.left do
              a(href: "#") { "Another left" }
            end

            level.right do
              render BulmaPhlex::Button.new(color: "primary") { "Action" }
            end
          end
        end

        h3(class: "label") { "Centered Content" }
        div(class: "mb-5") do
          render BulmaPhlex::Level.new do |level|
            level.left do
              plain "Some left content"
            end

            level.item do
              div do
                strong { "Centered title" }
                br
                span(class: "is-size-7") { "Small subtitle" }
              end
            end

            level.right do
              render BulmaPhlex::Button.new(outlined: true) { "Right" }
            end
          end
        end

        h3(class: "label") { "Icons and Badges" }
        div(class: "mb-5") do
          render BulmaPhlex::Level.new do |level|
            level.left do
              render BulmaPhlex::Icon.new("fas fa-bell", text_right: "Notifications")
            end

            level.right do
              span(class: "tag is-danger") { "3" }
            end

            level.right do
              render BulmaPhlex::Button.new(color: "info", icon_left: "fas fa-sync") { "Refresh" }
            end
          end
        end

        h3(class: "label") { "Responsive / Mixed Content" }
        div(class: "mb-5") do
          render BulmaPhlex::Level.new do |level|
            level.left do
              plain "Left"
            end

            level.left do
              span(class: "is-hidden-mobile") { plain "Hidden on mobile" }
            end

            level.right do
              render BulmaPhlex::Button.new(size: "small") { "Small" }
            end

            level.right do
              render BulmaPhlex::Button.new(size: "small", outlined: true) { "Settings" }
            end
          end
        end
      end
    end
  end
end
