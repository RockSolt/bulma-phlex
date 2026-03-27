# frozen_string_literal: true

module Playground
  module Sections
    class Icon < Phlex::HTML
      def view_template
        h2(class: "title is-4") { "Icon" }

        p(class: "content") do
          plain "Renders a Bulma icon element with an optional "
          code { "<i>" }
          plain " tag inside. Supports color, size, optional text, and positioning flags for use inside form controls."
        end

        h3(class: "subtitle is-5") { "Basic" }
        div(class: "mb-5") do
          render BulmaPhlex::Icon.new("fas fa-check")
          render BulmaPhlex::Icon.new("fas fa-times")
          render BulmaPhlex::Icon.new("fas fa-download")
        end

        h3(class: "subtitle is-5") { "Sizes" }
        div(class: "mb-5") do
          render BulmaPhlex::Icon.new("fas fa-star", size: :small)
          render BulmaPhlex::Icon.new("fas fa-star")
          render BulmaPhlex::Icon.new("fas fa-star", size: :medium)
          render BulmaPhlex::Icon.new("fas fa-star", size: :large)
        end

        h3(class: "subtitle is-5") { "Colors" }
        div(class: "mb-5") do
          render BulmaPhlex::Icon.new("fas fa-check", color: :success)
          render BulmaPhlex::Icon.new("fas fa-exclamation-triangle", color: :warning)
          render BulmaPhlex::Icon.new("fas fa-times", color: :danger)
          render BulmaPhlex::Icon.new("fas fa-info-circle", color: :info)
          render BulmaPhlex::Icon.new("fas fa-circle", color: :primary)
        end

        h3(class: "subtitle is-5") { "Size + Color" }
        div(class: "mb-5") do
          render BulmaPhlex::Icon.new("fas fa-home", size: :large, color: :primary)
          render BulmaPhlex::Icon.new("fas fa-bell", size: :medium, color: :danger)
        end

        h3(class: "subtitle is-5") { "Text Right (icon-text)" }
        div(class: "mb-5") do
          render BulmaPhlex::Icon.new("fas fa-home", text_right: "Home")
          render BulmaPhlex::Icon.new("fas fa-envelope", text_right: "Contact")
          render BulmaPhlex::Icon.new("fas fa-user", text_right: "Profile")
        end

        h3(class: "subtitle is-5") { "Text Left (icon-text)" }
        div(class: "mb-5") do
          render BulmaPhlex::Icon.new("fas fa-check", text_left: "Confirmed")
          render BulmaPhlex::Icon.new("fas fa-lock", text_left: "Secure")
        end

        h3(class: "subtitle is-5") { "Left / Right Flags (for form controls)" }
        p(class: "content is-small") do
          plain "The "
          code { "left: true" }
          plain " and "
          code { "right: true" }
          plain " flags add "
          code { "is-left" }
          plain " / "
          code { "is-right" }
          plain " positioning classes, used when placing icons inside a "
          code { "div.control.has-icons-left" }
          plain " or "
          code { "div.control.has-icons-right" }
          plain " wrapper."
        end
        div(class: "mb-5") do
          div(class: "field") do
            div(class: "control has-icons-left has-icons-right") do
              input(class: "input", type: "email", placeholder: "Email")
              render BulmaPhlex::Icon.new("fas fa-envelope", size: :small, left: true)
              render BulmaPhlex::Icon.new("fas fa-check", size: :small, right: true)
            end
          end
        end
      end
    end
  end
end
