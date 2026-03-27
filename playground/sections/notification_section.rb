# frozen_string_literal: true

module Playground
  module Sections
    class Notification < Phlex::HTML
      def view_template
        h2(class: "title is-4") { "Notification" }

        h3(class: "label") { "Colors" }
        div(class: "mb-5") do
          render BulmaPhlex::Notification.new(color: "primary") { "Primary notification" }
          render BulmaPhlex::Notification.new(color: "link") { "Link notification" }
          render BulmaPhlex::Notification.new(color: "info") { "Info notification" }
          render BulmaPhlex::Notification.new(color: "success") { "Success notification" }
          render BulmaPhlex::Notification.new(color: "warning") { "Warning notification" }
          render BulmaPhlex::Notification.new(color: "danger") { "Danger notification" }
        end

        h3(class: "label") { "Light Mode" }
        div(class: "mb-5") do
          render BulmaPhlex::Notification.new(color: "primary", mode: "light") { "Primary light notification" }
          render BulmaPhlex::Notification.new(color: "info", mode: "light") { "Info light notification" }
          render BulmaPhlex::Notification.new(color: "success", mode: "light") { "Success light notification" }
          render BulmaPhlex::Notification.new(color: "warning", mode: "light") { "Warning light notification" }
          render BulmaPhlex::Notification.new(color: "danger", mode: "light") { "Danger light notification" }
        end

        h3(class: "label") { "With Delete Button" }
        div(class: "mb-5") do
          render BulmaPhlex::Notification.new(color: "primary", delete: true) { "Dismissible primary notification" }
          render BulmaPhlex::Notification.new(color: "danger", delete: true) { "Dismissible danger notification" }
        end
      end
    end
  end
end
