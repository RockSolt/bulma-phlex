# frozen_string_literal: true

module Playground
  module Sections
    class FormField < Phlex::HTML
      def view_template
        h2(class: "title is-4") { "Form Field" }

        h3(class: "subtitle is-6 mt-4") { "String Label with Attributes + Help Text" }
        div(class: "mb-5") do
          render BulmaPhlex::FormField.new(help: "We'll never share your email.") do |f|
            f.label "Email", data: { controller: "label-help" }
            f.control { input(type: "email", class: "input", placeholder: "you@example.com") }
          end
        end

        h3(class: "subtitle is-6 mt-4") { "Block Label" }
        div(class: "mb-5") do
          render BulmaPhlex::FormField.new do |f|
            f.label do
              label(class: "label") do
                plain "Custom "
                span(class: "has-text-danger") { "*" }
                plain "Label"
              end
            end
            f.control { input(type: "text", class: "input", placeholder: "Enter value") }
          end
        end

        h3(class: "subtitle is-6 mt-4") { "No Label" }
        div(class: "mb-5") do
          render BulmaPhlex::FormField.new do |f|
            f.control { input(type: "text", class: "input", placeholder: "No label above") }
          end
        end

        h3(class: "subtitle is-6 mt-4") { "Icon Left" }
        div(class: "mb-5") do
          render BulmaPhlex::FormField.new(icon_left: "fas fa-user") do |f|
            f.label "Username"
            f.control { input(type: "text", class: "input", placeholder: "username") }
          end
        end

        h3(class: "subtitle is-6 mt-4") { "Icon Right" }
        div(class: "mb-5") do
          render BulmaPhlex::FormField.new(icon_right: "fas fa-check") do |f|
            f.label "Status"
            f.control { input(type: "text", class: "input", placeholder: "confirmed") }
          end
        end

        h3(class: "subtitle is-6 mt-4") { "Icons on Both Sides" }
        div(class: "mb-5") do
          render BulmaPhlex::FormField.new(icon_left: "fas fa-envelope", icon_right: "fas fa-check",
                                           help: "Looks good!") do |f|
            f.label "Email"
            f.control { input(type: "email", class: "input is-success", placeholder: "you@example.com") }
          end
        end

        h3(class: "subtitle is-6 mt-4") { "Implicit Control (no field.control call)" }
        div(class: "mb-5") do
          render BulmaPhlex::FormField.new(icon_left: "fas fa-search") do
            input(type: "text", class: "input", placeholder: "Search…")
          end
        end

        h3(class: "subtitle is-6 mt-4") { "Column — true" }
        div(class: "mb-5") do
          div(class: "columns") do
            render BulmaPhlex::FormField.new(column: true) do |f|
              f.label "First Name"
              f.control { input(type: "text", class: "input", placeholder: "First") }
            end
            render BulmaPhlex::FormField.new(column: true) do |f|
              f.label "Last Name"
              f.control { input(type: "text", class: "input", placeholder: "Last") }
            end
          end
        end

        h3(class: "subtitle is-6 mt-4") { "Column — with Size" }
        div(class: "mb-5") do
          div(class: "columns") do
            render BulmaPhlex::FormField.new(column: "two-thirds") do |f|
              f.label "Address"
              f.control { input(type: "text", class: "input", placeholder: "123 Main St") }
            end
            render BulmaPhlex::FormField.new(column: "one-third") do |f|
              f.label "Postal Code"
              f.control { input(type: "text", class: "input", placeholder: "12345") }
            end
          end
        end

        h3(class: "subtitle is-6 mt-4") { "Column — Responsive Breakpoint Sizes" }
        div(class: "mb-5") do
          div(class: "columns is-multiline") do
            render BulmaPhlex::FormField.new(column: { mobile: "full", tablet: "half", desktop: "one-third" }) do |f|
              f.label "Responsive Field"
              f.control { input(type: "text", class: "input", placeholder: "Full → Half → One-Third") }
            end
          end
        end

        h3(class: "subtitle is-6 mt-4") { "Grid — true" }
        div(class: "mb-5") do
          div(class: "grid") do
            render BulmaPhlex::FormField.new(grid: true) do |f|
              f.label "Cell Field A"
              f.control { input(type: "text", class: "input", placeholder: "Cell A") }
            end
            render BulmaPhlex::FormField.new(grid: true) do |f|
              f.label "Cell Field B"
              f.control { input(type: "text", class: "input", placeholder: "Cell B") }
            end
          end
        end

        h3(class: "subtitle is-6 mt-4") { "Grid — with Size" }
        div(class: "mb-5") do
          div(class: "grid") do
            render BulmaPhlex::FormField.new(grid: "col-span-2") do |f|
              f.label "Wide Field"
              f.control { input(type: "text", class: "input", placeholder: "Spans 2 columns") }
            end
            render BulmaPhlex::FormField.new(grid: true) do |f|
              f.label "Narrow Field"
              f.control { input(type: "text", class: "input", placeholder: "1 column") }
            end
          end
        end
      end
    end
  end
end
