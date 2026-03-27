# frozen_string_literal: true

module Playground
  module Sections
    class Button < Phlex::HTML
      def view_template
        h2(class: "title is-4") { "Button" }

        h3(class: "subtitle is-5") { "Colors" }
        div(class: "buttons mb-5") do
          render BulmaPhlex::Button.new("Primary", color: "primary")
          render BulmaPhlex::Button.new("Link", color: "link")
          render BulmaPhlex::Button.new("Info", color: "info")
          render BulmaPhlex::Button.new("Success", color: "success")
          render BulmaPhlex::Button.new("Warning", color: "warning")
          render BulmaPhlex::Button.new("Danger", color: "danger")
        end

        h3(class: "subtitle is-5") { "Mode (light / dark)" }
        div(class: "buttons mb-5") do
          render BulmaPhlex::Button.new("Primary Light", color: "primary", mode: "light")
          render BulmaPhlex::Button.new("Info Light", color: "info", mode: "light")
          render BulmaPhlex::Button.new("Success Light", color: "success", mode: "light")
          render BulmaPhlex::Button.new("Primary Dark", color: "primary", mode: "dark")
          render BulmaPhlex::Button.new("Info Dark", color: "info", mode: "dark")
        end

        h3(class: "subtitle is-5") { "Sizes (with labels from a block)" }
        div(class: "buttons mb-5 is-align-items-center") do
          render BulmaPhlex::Button.new(size: "small") { "Small" }
          render(BulmaPhlex::Button.new { "Normal" })
          render BulmaPhlex::Button.new(size: "medium") { "Medium" }
          render BulmaPhlex::Button.new(size: "large") { "Large" }
        end

        h3(class: "subtitle is-5") { "Outlined" }
        div(class: "buttons mb-5") do
          render BulmaPhlex::Button.new("Primary", color: "primary", outlined: true)
          render BulmaPhlex::Button.new("Link", color: "link", outlined: true)
          render BulmaPhlex::Button.new("Info", color: "info", outlined: true)
          render BulmaPhlex::Button.new("Success", color: "success", outlined: true)
          render BulmaPhlex::Button.new("Warning", color: "warning", outlined: true)
          render BulmaPhlex::Button.new("Danger", color: "danger", outlined: true)
        end

        h3(class: "subtitle is-5") { "Inverted" }
        div(class: "buttons mb-5 has-background-dark p-3") do
          render BulmaPhlex::Button.new("Primary", color: "primary", inverted: true)
          render BulmaPhlex::Button.new("Info", color: "info", inverted: true)
          render BulmaPhlex::Button.new("Warning", color: "warning", inverted: true)
          render BulmaPhlex::Button.new("Danger", color: "danger", inverted: true)
        end

        h3(class: "subtitle is-5") { "Rounded" }
        div(class: "buttons mb-5") do
          render BulmaPhlex::Button.new("Primary", color: "primary", rounded: true)
          render BulmaPhlex::Button.new("Link", color: "link", rounded: true)
          render BulmaPhlex::Button.new("Info", color: "info", rounded: true)
          render BulmaPhlex::Button.new("Success", color: "success", rounded: true)
          render BulmaPhlex::Button.new("Danger", color: "danger", rounded: true)
        end

        h3(class: "subtitle is-5") { "Responsive" }
        div(class: "buttons mb-5") do
          render BulmaPhlex::Button.new("Responsive", color: "primary", responsive: true)
          render BulmaPhlex::Button.new("Responsive Large", color: "info", responsive: true, size: "large")
        end

        h3(class: "subtitle is-5") { "Fullwidth" }
        div(class: "mb-5") do
          render BulmaPhlex::Button.new("Fullwidth Button", color: "primary", fullwidth: true)
        end

        h3(class: "subtitle is-5") { "With Icon Left / Icon Right" }
        div(class: "buttons mb-5") do
          render BulmaPhlex::Button.new("Save", color: "primary", icon_left: "fas fa-check")
          render BulmaPhlex::Button.new("Delete", color: "danger", icon_left: "fas fa-trash")
          render BulmaPhlex::Button.new("Next", icon_right: "fas fa-angle-right")
          render BulmaPhlex::Button.new("Export", color: "info", icon_left: "fas fa-download",
                                                  icon_right: "fas fa-angle-down")
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
          render BulmaPhlex::Button.new("Anchor", color: "primary", href: "#")
          render BulmaPhlex::Button.new("Outlined Anchor", color: "info", href: "#", outlined: true)
          render BulmaPhlex::Button.new("External", color: "success", href: "#", icon_left: "fas fa-external-link-alt")
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
