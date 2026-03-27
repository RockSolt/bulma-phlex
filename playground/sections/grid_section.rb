# frozen_string_literal: true

module Playground
  module Sections
    class Grid < Phlex::HTML
      def view_template
        h2(class: "title is-4") { "Grid" }

        p(class: "content") do
          plain "Renders a responsive grid layout using Bulma's grid system. Supports fixed or "
          plain "auto-count column layouts, minimum column width, and independent gap controls."
        end

        h3(class: "subtitle is-5") { "Basic Grid" }
        div(class: "mb-5") do
          render BulmaPhlex::Grid.new do
            div(class: "box") { plain "Item 1" }
            div(class: "box") { plain "Item 2" }
            div(class: "box") { plain "Item 3" }
            div(class: "box") { plain "Item 4" }
          end
        end

        h3(class: "subtitle is-5") { "HTML Attributes (id + data-*)" }
        div(class: "mb-5") do
          render BulmaPhlex::Grid.new(id: "my-grid", data: { controller: "grid" }) do
            div(class: "box") { plain "Item 1" }
            div(class: "box") { plain "Item 2" }
            div(class: "box") { plain "Item 3" }
          end
        end

        h3(class: "subtitle is-5") { "Fixed Columns (fixed_columns: 3)" }
        div(class: "mb-5") do
          render BulmaPhlex::Grid.new(fixed_columns: 3) do
            div(class: "box") { plain "Column A" }
            div(class: "box") { plain "Column B" }
            div(class: "box") { plain "Column C" }
          end
        end

        h3(class: "subtitle is-5") { "Fixed Columns (fixed_columns: 4)" }
        div(class: "mb-5") do
          render BulmaPhlex::Grid.new(fixed_columns: 4) do
            div(class: "box") { plain "1" }
            div(class: "box") { plain "2" }
            div(class: "box") { plain "3" }
            div(class: "box") { plain "4" }
          end
        end

        h3(class: "subtitle is-5") { "Auto Count (auto_count: true)" }
        div(class: "mb-5") do
          render BulmaPhlex::Grid.new(auto_count: true) do
            div(class: "box") { plain "Auto 1" }
            div(class: "box") { plain "Auto 2" }
            div(class: "box") { plain "Auto 3" }
            div(class: "box") { plain "Auto 4" }
            div(class: "box") { plain "Auto 5" }
          end
        end

        h3(class: "subtitle is-5") { "Minimum Column Width (minimum_column_width: 10)" }
        div(class: "mb-5") do
          render BulmaPhlex::Grid.new(minimum_column_width: 10) do
            div(class: "box") { plain "Item 1" }
            div(class: "box") { plain "Item 2" }
            div(class: "box") { plain "Item 3" }
          end
        end

        h3(class: "subtitle is-5") { "Gap (gap: 2)" }
        div(class: "mb-5") do
          render BulmaPhlex::Grid.new(gap: 2) do
            div(class: "box") { plain "Item 1" }
            div(class: "box") { plain "Item 2" }
            div(class: "box") { plain "Item 3" }
          end
        end

        h3(class: "subtitle is-5") { "Column Gap and Row Gap (column_gap: 4, row_gap: 1)" }
        div(class: "mb-5") do
          render BulmaPhlex::Grid.new(column_gap: 4, row_gap: 1) do
            div(class: "box") { plain "Item 1" }
            div(class: "box") { plain "Item 2" }
            div(class: "box") { plain "Item 3" }
            div(class: "box") { plain "Item 4" }
          end
        end
      end
    end
  end
end
