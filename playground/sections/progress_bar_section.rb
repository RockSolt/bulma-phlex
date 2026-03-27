# frozen_string_literal: true

module Playground
  module Sections
    class ProgressBar < Phlex::HTML
      def view_template
        h2(class: "title is-4") { "Progress Bar" }

        p(class: "content") do
          plain "Renders a "
          code { "progress" }
          plain " element. Pass "
          code { "value:" }
          plain " and "
          code { "max:" }
          plain " as HTML attributes. Omit both for an indeterminate (animated) bar. "
          plain "The block provides fallback text for browsers that do not support the element."
        end

        h3(class: "subtitle is-5") { "Basic (no value/max)" }
        div(class: "mb-5") do
          render(BulmaPhlex::ProgressBar.new { "Loading…" })
        end

        h3(class: "subtitle is-5") { "With value and max" }
        div(class: "mb-5") do
          render BulmaPhlex::ProgressBar.new(value: 45, max: 100) { "45%" }
        end

        h3(class: "subtitle is-5") { "Colors" }
        div(class: "mb-5") do
          render BulmaPhlex::ProgressBar.new(color: "primary", value: 20, max: 100) { "20%" }
          render BulmaPhlex::ProgressBar.new(color: "info",    value: 40, max: 100) { "40%" }
          render BulmaPhlex::ProgressBar.new(color: "success", value: 60, max: 100) { "60%" }
          render BulmaPhlex::ProgressBar.new(color: "warning", value: 75, max: 100) { "75%" }
          render BulmaPhlex::ProgressBar.new(color: "danger",  value: 90, max: 100) { "90%" }
        end

        h3(class: "subtitle is-5") { "Sizes" }
        div(class: "mb-5") do
          render BulmaPhlex::ProgressBar.new(size: "small",  value: 30, max: 100) { "30%" }
          render BulmaPhlex::ProgressBar.new(value: 50, max: 100) { "50%" }
          render BulmaPhlex::ProgressBar.new(size: "medium", value: 70, max: 100) { "70%" }
          render BulmaPhlex::ProgressBar.new(size: "large",  value: 85, max: 100) { "85%" }
        end

        h3(class: "subtitle is-5") { "Indeterminate / Animated (omit value and max)" }
        div(class: "mb-5") do
          render BulmaPhlex::ProgressBar.new(color: "primary") { "Loading…" }
          render BulmaPhlex::ProgressBar.new(color: "info")    { "Loading…" }
        end

        h3(class: "subtitle is-5") { "All options combined" }
        div(class: "mb-5") do
          render BulmaPhlex::ProgressBar.new(color: "success", size: "large", value: 72, max: 100) { "72%" }
        end

        h3(class: "subtitle is-5") { "Custom max" }
        div(class: "mb-5") do
          render BulmaPhlex::ProgressBar.new(value: 3, max: 7) { "3 / 7" }
        end
      end
    end
  end
end
