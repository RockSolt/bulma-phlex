# frozen_string_literal: true

module Playground
  module Sections
    class Table < Phlex::HTML
      User = Struct.new(:id, :name, :email, :role, :active, :joined_at)

      USERS = [
        User.new(1, "Alice Johnson", "alice@example.com", "Developer", true,  Time.new(2023, 1, 15)),
        User.new(2, "Bob Smith",     "bob@example.com",   "Designer",  false, Time.new(2023, 6, 3)),
        User.new(3, "Carol Davis",   "carol@example.com", "Product",   true,  Time.new(2024, 2, 20)),
        User.new(4, "Dan Lee",       "dan@example.com",   "Admin",     true,  Time.new(2024, 8, 7))
      ].freeze

      def view_template
        h2(class: "title is-4") { "Table" }

        h3(class: "label") { "Basic Table" }
        div(class: "mb-5") do
          render BulmaPhlex::Table.new(USERS) do |table|
            table.column("ID", &:id)
            table.column("Name", &:name)
            table.column("Email", &:email)
            table.column("Role", &:role)
          end
        end

        h3(class: "label") { "Bordered, Striped, Hoverable" }
        div(class: "mb-5") do
          render BulmaPhlex::Table.new(USERS, bordered: true, striped: true, hoverable: true) do |table|
            table.column("Name", &:name)
            table.column("Email", &:email)
            table.column("Role", &:role)
          end
        end

        h3(class: "label") { "Narrow & Full Width" }
        div(class: "mb-5") do
          render BulmaPhlex::Table.new(USERS, narrow: true, fullwidth: true) do |table|
            table.column("ID", &:id)
            table.column("Name", &:name)
            table.column("Role", &:role)
          end
        end

        h3(class: "label") { "Date Column" }
        div(class: "mb-5") do
          render BulmaPhlex::Table.new(USERS) do |table|
            table.column("Name", &:name)
            table.date_column("Joined", &:joined_at)
            table.date_column("Joined (custom format)", format: "%B %-d, %Y", &:joined_at)
          end
        end

        h3(class: "label") { "Conditional Icon Column" }
        div(class: "mb-5") do
          render BulmaPhlex::Table.new(USERS) do |table|
            table.column("Name", &:name)
            table.column("Role", &:role)
            table.conditional_icon("Active", icon_class: "fas fa-check", &:active)
          end
        end

        h3(class: "label") { "Combined Styles" }
        div(class: "mb-5") do
          render BulmaPhlex::Table.new(USERS, bordered: true, striped: true, narrow: true) do |table|
            table.column("ID", &:id)
            table.column("Name", &:name)
            table.column("Email", &:email)
            table.date_column("Joined", &:joined_at)
            table.conditional_icon("Active", &:active)
          end
        end

        h3(class: "label") { "With Custom HTML Attributes" }
        div(class: "mb-5") do
          render BulmaPhlex::Table.new(USERS, class: "projects", data: { test: "value" }) do |table|
            table.column("Name", &:name)
            table.column("Email", &:email)
          end
        end

        h3(class: "label") { "Empty Table" }
        div(class: "mb-5") do
          render BulmaPhlex::Table.new([]) do |table|
            table.column("Name", &:name)
            table.column("Email", &:email)
          end
        end
      end
    end
  end
end
