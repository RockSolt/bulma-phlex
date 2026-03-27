# frozen_string_literal: true

module Playground
  module Sections
    class Columns < Phlex::HTML
      def view_template
        h2(class: "title is-4") { "Columns" }

        h3(class: "subtitle is-5") { "Simple Columns" }
        div(class: "mb-5") do
          render BulmaPhlex::Columns.new do
            div(class: "column box") { plain "Column 1" }
            div(class: "column box") { plain "Column 2" }
            div(class: "column box") { plain "Column 3" }
          end
        end

        h3(class: "subtitle is-5") { "Minimum Breakpoint (minimum_breakpoint: :desktop)" }
        div(class: "mb-5") do
          render BulmaPhlex::Columns.new(minimum_breakpoint: :desktop) do
            div(class: "column box") { plain "Stacked until desktop" }
            div(class: "column box") { plain "Stacked until desktop" }
            div(class: "column box") { plain "Stacked until desktop" }
          end
        end

        h3(class: "subtitle is-5") { "Multiline" }
        div(class: "mb-5") do
          render BulmaPhlex::Columns.new(multiline: true) do
            1.upto(6) do |i|
              div(class: "column is-one-third box") { plain "Item #{i}" }
            end
          end
        end

        h3(class: "subtitle is-5") { "Centered" }
        div(class: "mb-5") do
          render BulmaPhlex::Columns.new(centered: true) do
            div(class: "column is-narrow box") { plain "Centered narrow" }
            div(class: "column is-narrow box") { plain "Centered narrow" }
          end
        end

        h3(class: "subtitle is-5") { "Vertically Centered" }
        div(class: "mb-5") do
          render BulmaPhlex::Columns.new(vcentered: true) do
            div(class: "column") do
              div(class: "box") { plain "Short" }
            end
            div(class: "column") do
              div(class: "box", style: "padding-top: 2rem; padding-bottom: 2rem;") do
                plain "Taller content — neighbours are vertically centred"
              end
            end
            div(class: "column") do
              div(class: "box") { plain "Short" }
            end
          end
        end

        h3(class: "subtitle is-5") { "Gap — integer (gap: 6)" }
        div(class: "mb-5") do
          render BulmaPhlex::Columns.new(gap: 6) do
            div(class: "column box") { plain "Wide gap A" }
            div(class: "column box") { plain "Wide gap B" }
            div(class: "column box") { plain "Wide gap C" }
          end
        end

        h3(class: "subtitle is-5") { "Gap — per breakpoint (gap: { mobile: 2, desktop: 6 })" }
        div(class: "mb-5") do
          render BulmaPhlex::Columns.new(gap: { mobile: 2, desktop: 6 }) do
            div(class: "column box") { plain "Responsive gap A" }
            div(class: "column box") { plain "Responsive gap B" }
            div(class: "column box") { plain "Responsive gap C" }
          end
        end
      end
    end
  end
end
