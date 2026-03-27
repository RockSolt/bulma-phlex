# frozen_string_literal: true

module Playground
  module Sections
    class Tabs < Phlex::HTML
      def view_template
        h2(class: "title is-4") { "Tabs" }

        h3(class: "subtitle is-5") { "Simple Tabs" }
        div(class: "mb-5") do
          render BulmaPhlex::Tabs.new do |tabs|
            tabs.tab(id: "overview", title: "Overview", active: true) do
              div do
                h4(class: "title is-6") { "Overview" }
                p { "This is the overview tab content. It demonstrates the default active tab." }
              end
            end

            tabs.tab(id: "modifiers", title: "Modifiers") do
              div do
                h4(class: "title is-6") { "Modifiers" }
                p { "Explain various modifiers and options for tabs (alignment, boxed, toggle)." }
              end
            end

            tabs.tab(id: "settings", title: "Settings") do
              div do
                h4(class: "title is-6") { "Settings" }
                p { "Settings content goes here — forms, switches, and preferences." }
              end
            end
          end
        end

        h3(class: "subtitle is-5") { "Boxed + Centered (boxed: true, align: :centered)" }
        div(class: "mb-5") do
          render BulmaPhlex::Tabs.new(boxed: true, align: :centered) do |tabs|
            tabs.tab(id: "profile", title: "Profile", active: true) do
              p { "This boxed, centered example shows how those Bulma modifiers look together." }
            end

            tabs.tab(id: "tasks", title: "Tasks") do
              p { "Your tasks will appear here." }
            end

            tabs.tab(id: "prefs", title: "Settings") do
              p { "Preference controls go here." }
            end
          end
        end

        h3(class: "subtitle is-5") { "Aligned Right (align: :right)" }
        div(class: "mb-5") do
          render BulmaPhlex::Tabs.new(align: :right) do |tabs|
            tabs.tab(id: "right-one", title: "Alpha", active: true) do
              p { "Alpha content." }
            end

            tabs.tab(id: "right-two", title: "Beta") do
              p { "Beta content." }
            end

            tabs.tab(id: "right-three", title: "Gamma") do
              p { "Gamma content." }
            end
          end
        end

        h3(class: "subtitle is-5") { "Small Size (size: \"small\")" }
        div(class: "mb-5") do
          render BulmaPhlex::Tabs.new(size: "small") do |tabs|
            tabs.tab(id: "sm-one", title: "First", active: true) do
              p { "First tab content." }
            end

            tabs.tab(id: "sm-two", title: "Second") do
              p { "Second tab content." }
            end

            tabs.tab(id: "sm-three", title: "Third") do
              p { "Third tab content." }
            end
          end
        end

        h3(class: "subtitle is-5") { "Large Size (size: \"large\")" }
        div(class: "mb-5") do
          render BulmaPhlex::Tabs.new(size: "large") do |tabs|
            tabs.tab(id: "lg-one", title: "First", active: true) do
              p { "First tab content." }
            end

            tabs.tab(id: "lg-two", title: "Second") do
              p { "Second tab content." }
            end
          end
        end

        h3(class: "subtitle is-5") { "With Icons" }
        div(class: "mb-5") do
          render BulmaPhlex::Tabs.new do |tabs|
            tabs.tab(id: "home", title: "Home", icon: "fas fa-home", active: true) do
              p { "Welcome home! This tab has an icon." }
            end

            tabs.tab(id: "reports", title: "Reports", icon: "fas fa-chart-line") do
              p { "Reports and analytics content." }
            end

            tabs.tab(id: "tools", title: "Tools", icon: "fas fa-cog") do
              p { "Tool configuration lives here." }
            end
          end
        end

        h3(class: "subtitle is-5") { "Toggle Style (toggle: true)" }
        div(class: "mb-5") do
          render BulmaPhlex::Tabs.new(toggle: true) do |tabs|
            tabs.tab(id: "toggle-one", title: "Option A", active: true) do
              p { "Content for Option A." }
            end

            tabs.tab(id: "toggle-two", title: "Option B") do
              p { "Content for Option B." }
            end
          end
        end

        h3(class: "subtitle is-5") { "Toggle Rounded (rounded: true)" }
        div(class: "mb-5") do
          render BulmaPhlex::Tabs.new(rounded: true) do |tabs|
            tabs.tab(id: "rounded-one", title: "First", active: true) do
              p { "Content for the first rounded-toggle tab." }
            end

            tabs.tab(id: "rounded-two", title: "Second") do
              p { "Content for the second rounded-toggle tab." }
            end
          end
        end

        h3(class: "subtitle is-5") { "Full Width (fullwidth: true)" }
        div(class: "mb-5") do
          render BulmaPhlex::Tabs.new(fullwidth: true) do |tabs|
            tabs.tab(id: "fw-one", title: "Alpha", active: true) do
              p { "Alpha content." }
            end

            tabs.tab(id: "fw-two", title: "Beta") do
              p { "Beta content." }
            end

            tabs.tab(id: "fw-three", title: "Gamma") do
              p { "Gamma content." }
            end
          end
        end

        h3(class: "subtitle is-5") { "With Right Content" }
        div(class: "mb-5") do
          render BulmaPhlex::Tabs.new do |tabs|
            tabs.tab(id: "rc-one", title: "Summary", active: true) do
              p { "Summary tab content." }
            end

            tabs.tab(id: "rc-two", title: "Details") do
              p { "Details tab content." }
            end

            tabs.right_content do
              button(class: "button is-small is-primary") { "Action" }
            end
          end
        end
      end
    end
  end
end
