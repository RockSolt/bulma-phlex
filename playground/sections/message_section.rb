# frozen_string_literal: true

module Playground
  module Sections
    class Message < Phlex::HTML
      def view_template
        h2(class: "title is-4") { "Message" }

        h3(class: "subtitle is-5") { "Colors" }
        div(class: "mb-5") do
          render BulmaPhlex::Message.new("Primary", color: "primary") { "Primary message body." }
          render BulmaPhlex::Message.new("Link", color: "link") { "Link message body." }
          render BulmaPhlex::Message.new("Info", color: "info") { "Info message body." }
          render BulmaPhlex::Message.new("Success", color: "success") { "Success message body." }
          render BulmaPhlex::Message.new("Warning", color: "warning") { "Warning message body." }
          render BulmaPhlex::Message.new("Danger", color: "danger") { "Danger message body." }
        end

        h3(class: "subtitle is-5") { "Sizes" }
        div(class: "mb-5") do
          render BulmaPhlex::Message.new("Small", color: "info", size: "small") { "A small message." }
          render BulmaPhlex::Message.new("Normal (default)", color: "info") { "A normal message." }
          render BulmaPhlex::Message.new("Medium", color: "info", size: "medium") { "A medium message." }
          render BulmaPhlex::Message.new("Large", color: "info", size: "large") { "A large message." }
        end

        h3(class: "subtitle is-5") { "With Delete Button" }
        div(class: "mb-5") do
          render BulmaPhlex::Message.new("Dismissible", color: "warning", delete: true) do
            "This message has a delete button in its header."
          end
        end

        h3(class: "subtitle is-5") { "Body Only (no header)" }
        div(class: "mb-5") do
          render BulmaPhlex::Message.new(color: "info") { "No header — just a styled message body." }
          render BulmaPhlex::Message.new(color: "warning") { "Another body-only message in warning." }
        end

        h3(class: "subtitle is-5") { "With List Content" }
        div(class: "mb-5") do
          render BulmaPhlex::Message.new("Action Required", color: "danger") do
            ul do
              li { plain "Fix the broken link on the homepage." }
              li { plain "Update your billing information." }
              li { plain "Verify your email address." }
            end
          end
        end
      end
    end
  end
end
