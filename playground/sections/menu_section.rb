# frozen_string_literal: true

module Playground
  module Sections
    class Menu < Phlex::HTML
      def view_template
        h2(class: "title is-4") { "Menu" }

        h3(class: "subtitle is-5") { "Basic Menu" }
        div(class: "mb-5") do
          render BulmaPhlex::Menu.new do |menu|
            menu.label "General"
            menu.list do |list|
              list.item "Dashboard", href: "#dashboard"
              list.item "Customers", href: "#customers"
            end
          end
        end

        h3(class: "subtitle is-5") { "Active Item" }
        div(class: "mb-5") do
          render BulmaPhlex::Menu.new do |menu|
            menu.label "General"
            menu.list do |list|
              list.item "Dashboard", href: "#dashboard", active: true
              list.item "Customers", href: "#customers"
            end
          end
        end

        h3(class: "subtitle is-5") { "Nested List" }
        div(class: "mb-5") do
          render BulmaPhlex::Menu.new do |menu|
            menu.label "General"
            menu.list do |list|
              list.item "Dashboard", href: "#dashboard"
              list.item "Customers", href: "#customers" do |nested|
                nested.item "Active Customers", href: "#active-customers"
                nested.item "Inactive Customers", href: "#inactive-customers"
              end
            end
          end
        end

        h3(class: "subtitle is-5") { "Expandable Item" }
        div(class: "mb-5") do
          render BulmaPhlex::Menu.new do |menu|
            menu.label "General"
            menu.list do |list|
              list.item "Dashboard", href: "#dashboard"
              list.expandable_item("Customers", open: true) do |nested|
                nested.item "Active Customers", href: "#active-customers"
                nested.item "Inactive Customers", href: "#inactive-customers"
              end
              list.expandable_item("Settings", open: false) do |nested|
                nested.item "Profile", href: "#profile"
                nested.item "Security", href: "#security"
              end
            end
          end
        end
      end
    end
  end
end
