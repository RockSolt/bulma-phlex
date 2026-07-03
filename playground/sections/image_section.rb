# frozen_string_literal: true

module Playground
  module Sections
    class Image < Phlex::HTML
      def view_template
        h2(class: "title is-4") { "Image" }

        h3(class: "label") { "With size (128)" }
        div(class: "mb-5") do
          render BulmaPhlex::Image.new(
            src: "https://bulma.io/assets/images/placeholders/128x128.png",
            size: 128
          )
        end

        h3(class: "label mb-4") { "With ratio (16x9)" }
        div(class: "mb-5 columns") do
          div(class: "is-half") do
            render BulmaPhlex::Image.new(
              src: "https://bulma.io/assets/images/placeholders/640x360.png",
              ratio: "16x9"
            )
          end
        end

        h3(class: "label") { "With rounded" }
        div(class: "mb-5") do
          render BulmaPhlex::Image.new(
            src: "https://bulma.io/assets/images/placeholders/128x128.png",
            size: 128,
            rounded: true
          )
        end
      end
    end
  end
end
