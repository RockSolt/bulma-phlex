# frozen_string_literal: true

module Playground
  module Sections
    class Button < Phlex::HTML
      def view_template
        h2(class: "title is-4") { "Button" }

        h3(class: "subtitle is-5") { "Colors" }
        div(class: "buttons mb-5") do
          render BulmaPhlex::Button.new(color: "primary") { "Primary" }
          render BulmaPhlex::Button.new(color: "link") { "Link" }
          render BulmaPhlex::Button.new(color: "info") { "Info" }
          render BulmaPhlex::Button.new(color: "success") { "Success" }
          render BulmaPhlex::Button.new(color: "warning") { "Warning" }
          render BulmaPhlex::Button.new(color: "danger") { "Danger" }
        end

        h3(class: "subtitle is-5") { "Mode (light / dark)" }
        div(class: "buttons mb-5") do
          render BulmaPhlex::Button.new(color: "primary", mode: "light") { "Primary Light" }
          render BulmaPhlex::Button.new(color: "info", mode: "light") { "Info Light" }
          render BulmaPhlex::Button.new(color: "success", mode: "light") { "Success Light" }
          render BulmaPhlex::Button.new(color: "primary", mode: "dark") { "Primary Dark" }
          render BulmaPhlex::Button.new(color: "info", mode: "dark") { "Info Dark" }
        end

        h3(class: "subtitle is-5") { "Sizes" }
        div(class: "buttons mb-5 is-align-items-center") do
          render BulmaPhlex::Button.new(size: "small") { "Small" }
          render(BulmaPhlex::Button.new { "Normal" })
          render BulmaPhlex::Button.new(size: "medium") { "Medium" }
          render BulmaPhlex::Button.new(size: "large") { "Large" }
        end

        h3(class: "subtitle is-5") { "Outlined" }
        div(class: "buttons mb-5") do
          render BulmaPhlex::Button.new(color: "primary", outlined: true) { "Primary" }
          render BulmaPhlex::Button.new(color: "link", outlined: true) { "Link" }
          render BulmaPhlex::Button.new(color: "info", outlined: true) { "Info" }
          render BulmaPhlex::Button.new(color: "success", outlined: true) { "Success" }
          render BulmaPhlex::Button.new(color: "warning", outlined: true) { "Warning" }
          render BulmaPhlex::Button.new(color: "danger", outlined: true) { "Danger" }
        end

        h3(class: "subtitle is-5") { "Inverted" }
        div(class: "buttons mb-5 has-background-dark p-3") do
          render BulmaPhlex::Button.new(color: "primary", inverted: true) { "Primary" }
          render BulmaPhlex::Button.new(color: "info", inverted: true) { "Info" }
          render BulmaPhlex::Button.new(color: "warning", inverted: true) { "Warning" }
          render BulmaPhlex::Button.new(color: "danger", inverted: true) { "Danger" }
        end

        h3(class: "subtitle is-5") { "Rounded" }
        div(class: "buttons mb-5") do
          render BulmaPhlex::Button.new(color: "primary", rounded: true) { "Primary" }
          render BulmaPhlex::Button.new(color: "link", rounded: true) { "Link" }
          render BulmaPhlex::Button.new(color: "info", rounded: true) { "Info" }
          render BulmaPhlex::Button.new(color: "success", rounded: true) { "Success" }
          render BulmaPhlex::Button.new(color: "danger", rounded: true) { "Danger" }
        end

        h3(class: "subtitle is-5") { "Responsive" }
        div(class: "buttons mb-5") do
          render BulmaPhlex::Button.new(color: "primary", responsive: true) { "Responsive" }
          render BulmaPhlex::Button.new(color: "info", responsive: true, size: "large") { "Responsive Large" }
        end

        h3(class: "subtitle is-5") { "Fullwidth" }
        div(class: "mb-5") do
          render BulmaPhlex::Button.new(color: "primary", fullwidth: true) { "Fullwidth Button" }
        end

        h3(class: "subtitle is-5") { "With Icon Left / Icon Right" }
        div(class: "buttons mb-5") do
          render BulmaPhlex::Button.new(color: "primary", icon_left: "fas fa-check") { "Save" }
          render BulmaPhlex::Button.new(color: "danger", icon_left: "fas fa-trash") { "Delete" }
          render BulmaPhlex::Button.new(icon_right: "fas fa-angle-right") { "Next" }
          render BulmaPhlex::Button.new(color: "info", icon_left: "fas fa-download", icon_right: "fas fa-angle-down") { "Export" }
        end

        h3(class: "subtitle is-5") { "Icon Only (icon:)" }
        div(class: "buttons mb-5") do
          render BulmaPhlex::Button.new(icon: "fas fa-home")
          render BulmaPhlex::Button.new(color: "primary", icon: "fas fa-check")
          render BulmaPhlex::Button.new(color: "danger", icon: "fas fa-trash")
          render BulmaPhlex::Button.new(color: "info", size: "large", icon: "fas fa-search")
        end

        h3(class: "subtitle is-5") { "As Anchor (href:)" }
        div(class: "buttons mb-5") do
          render BulmaPhlex::Button.new(color: "primary", href: "#") { "Anchor" }
          render BulmaPhlex::Button.new(color: "info", href: "#", outlined: true) { "Outlined Anchor" }
          render BulmaPhlex::Button.new(color: "success", href: "#", icon_left: "fas fa-external-link-alt") { "External" }
        end

        h3(class: "subtitle is-5") { "As Input (input:)" }
        div(class: "buttons mb-5") do
          render BulmaPhlex::Button.new(color: "primary", input: "submit", value: "Submit Form")
          render BulmaPhlex::Button.new(input: "reset", value: "Reset")
        end
      end
    end
  end
end
