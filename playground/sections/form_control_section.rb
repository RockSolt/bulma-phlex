# frozen_string_literal: true

module Playground
  module Sections
    class FormControl < Phlex::HTML
      def view_template
        h2(class: "title is-4") { "Form Control" }

        p(class: "content") do
          plain "Wraps form elements in a "
          code { "div.control" }
          plain " container. Supports optional icons on the left and/or right side."
        end

        h3(class: "subtitle is-5") { "Basic Control" }
        div(class: "mb-5") do
          render BulmaPhlex::FormControl.new do
            input(class: "input", type: "text", placeholder: "e.g. Alex Smith")
          end
        end

        h3(class: "subtitle is-5") { "Icon Left" }
        div(class: "mb-5") do
          render BulmaPhlex::FormControl.new(icon_left: "fas fa-envelope") do
            input(class: "input", type: "email", placeholder: "e.g. alex@example.com")
          end
        end

        h3(class: "subtitle is-5") { "Icon Right" }
        div(class: "mb-5") do
          render BulmaPhlex::FormControl.new(icon_right: "fas fa-check") do
            input(class: "input", type: "text", placeholder: "Validated field")
          end
        end

        h3(class: "subtitle is-5") { "Icons Left and Right" }
        div(class: "mb-5") do
          render BulmaPhlex::FormControl.new(icon_left: "fas fa-user", icon_right: "fas fa-check") do
            input(class: "input", type: "text", placeholder: "Username")
          end
        end

        h3(class: "subtitle is-5") { "Additional HTML Attributes (is-expanded + data-*)" }
        div(class: "mb-5 field has-addons") do
          p(class: "control") do
            a(class: "button is-static") { "https://" }
          end
          render BulmaPhlex::FormControl.new(class: "is-expanded", data: { controller: "url" }) do
            input(class: "input", type: "text", placeholder: "example.com")
          end
        end
      end
    end
  end
end
