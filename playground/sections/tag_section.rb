# frozen_string_literal: true

module Playground
  module Sections
    class Tag < Phlex::HTML
      def view_template
        h2(class: "title is-4") { "Tag" }

        p(class: "content") do
          plain "Renders a "
          code { "<span>" }
          plain ", "
          code { "<a>" }
          plain ", or "
          code { "<button>" }
          plain " element depending on the provided attributes."
        end

        h3(class: "subtitle is-5") { "Colors" }
        div(class: "tags mb-5") do
          render BulmaPhlex::Tag.new("Default")
          render BulmaPhlex::Tag.new("Primary", color: "primary")
          render BulmaPhlex::Tag.new("Link", color: "link")
          render BulmaPhlex::Tag.new("Info", color: "info")
          render BulmaPhlex::Tag.new("Success", color: "success")
          render BulmaPhlex::Tag.new("Warning", color: "warning")
          render BulmaPhlex::Tag.new("Danger", color: "danger")
        end

        h3(class: "subtitle is-5") { "Light Colors" }
        div(class: "tags mb-5") do
          render BulmaPhlex::Tag.new("Primary", light: "primary")
          render BulmaPhlex::Tag.new("Link", light: "link")
          render BulmaPhlex::Tag.new("Info", light: "info")
          render BulmaPhlex::Tag.new("Success", light: "success")
          render BulmaPhlex::Tag.new("Warning", light: "warning")
          render BulmaPhlex::Tag.new("Danger", light: "danger")
        end

        h3(class: "subtitle is-5") { "Sizes" }
        div(class: "tags mb-5 is-align-items-center") do
          render BulmaPhlex::Tag.new("Normal", color: "primary")
          render BulmaPhlex::Tag.new("Medium", color: "primary", size: "medium")
          render BulmaPhlex::Tag.new("Large", color: "primary", size: "large")
        end

        h3(class: "subtitle is-5") { "Rounded" }
        div(class: "tags mb-5") do
          render BulmaPhlex::Tag.new("Primary", color: "primary", rounded: true)
          render BulmaPhlex::Tag.new("Info", color: "info", rounded: true)
          render BulmaPhlex::Tag.new("Success", color: "success", rounded: true)
          render BulmaPhlex::Tag.new("Warning", color: "warning", rounded: true)
          render BulmaPhlex::Tag.new("Danger", color: "danger", rounded: true)
        end

        h3(class: "subtitle is-5") { "As Link (href: renders <a>)" }
        div(class: "tags mb-5") do
          render BulmaPhlex::Tag.new("Clickable", color: "info", href: "#")
          render BulmaPhlex::Tag.new("Rounded Link", color: "primary", rounded: true, href: "#")
          render BulmaPhlex::Tag.new("Large Link", color: "success", size: "large", href: "#")
        end

        h3(class: "subtitle is-5") { "Delete Button (delete: true renders <button>)" }
        div(class: "tags mb-5 is-align-items-center") do
          render BulmaPhlex::Tag.new("Normal + Delete", color: "primary", delete: true)
          render BulmaPhlex::Tag.new("Medium + Delete", color: "info", size: "medium", delete: true)
          render BulmaPhlex::Tag.new("Large + Delete", color: "success", size: "large", delete: true)
        end

        h3(class: "subtitle is-5") { "Anchor + Delete (href: + delete: renders <a> with delete span)" }
        div(class: "tags mb-5") do
          render BulmaPhlex::Tag.new("Remove me", color: "warning", href: "#", delete: true)
          render BulmaPhlex::Tag.new("Dismiss", color: "danger", href: "#", delete: true)
        end
      end
    end
  end
end
