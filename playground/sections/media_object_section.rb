# frozen_string_literal: true

module Playground
  module Sections
    class MediaObject < Phlex::HTML
      def view_template
        h2(class: "title is-4") { "Media Object" }

        div(class: "grid") do
          div(class: "cell") do
            h3(class: "label") { "Basic" }
            div(class: "mb-5") do
              render BulmaPhlex::MediaObject.new do |mo|
                mo.image(src: "https://bulma.io/assets/images/placeholders/128x128.png",
                         alt: "Placeholder image",
                         size: 128)
                mo.content do
                  p(class: "content") do
                    strong { "John Smith" }
                    small { "@johnsmith" }
                    br
                    plain <<~TEXT
                      Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin ornare magna eros, eu pellentesque tortor vestibulum ut. Maecenas non massa sem. Etiam finibus odio quis feugiat facilisis.
                    TEXT
                  end
                end
              end
            end
          end

          div(class: "cell") do
            h3(class: "label") { "Rounded, Small" }
            div(class: "mb-5") do
              render BulmaPhlex::MediaObject.new do |mo|
                mo.image(src: "https://bulma.io/assets/images/placeholders/64x64.png",
                         alt: "Placeholder image",
                         size: 64,
                         rounded: true)
                mo.content do
                  p(class: "content") do
                    strong { "John Smith" }
                    small { "@johnsmith" }
                    br
                    plain <<~TEXT
                      Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin ornare magna eros, eu pellentesque tortor vestibulum ut. Maecenas non massa sem. Etiam finibus odio quis feugiat facilisis.
                    TEXT
                  end
                end
              end
            end
          end
        end

        h3(class: "label") { "Nested" }
        render BulmaPhlex::MediaObject.new do |mo|
          mo.image(src: "https://bulma.io/assets/images/placeholders/128x128.png",
                   alt: "Placeholder image",
                   size: 128)
          mo.content do
            p(class: "content") do
              strong { "John Smith" }
              small { "@johnsmith" }
              br
              plain <<~TEXT
                Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin ornare magna eros, eu pellentesque tortor vestibulum ut. Maecenas non massa sem. Etiam finibus odio quis feugiat facilisis.
              TEXT
              br
              small do
                a(href: "#") { "Like" }
                plain " · "
                a(href: "#") { "Reply" }
              end
            end

            render BulmaPhlex::MediaObject.new do |mo|
              mo.image(src: "https://bulma.io/assets/images/placeholders/128x128.png",
                       alt: "Placeholder image",
                       size: 128)
              mo.content do
                p(class: "content") do
                  strong { "John Smith" }
                  small { "@johnsmith" }
                  br
                  plain <<~TEXT
                    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin ornare magna eros, eu pellentesque tortor vestibulum ut. Maecenas non massa sem. Etiam finibus odio quis feugiat facilisis.
                  TEXT
                end
              end
            end

            render BulmaPhlex::MediaObject.new do |mo|
              mo.image(src: "https://bulma.io/assets/images/placeholders/64x64.png",
                       alt: "Placeholder image",
                       size: 64,
                       rounded: true)
              mo.content do
                p(class: "content") do
                  strong { "John Smith" }
                  small { "@johnsmith" }
                  br
                  plain <<~TEXT
                    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin ornare magna eros, eu pellentesque tortor vestibulum ut. Maecenas non massa sem. Etiam finibus odio quis feugiat facilisis.
                  TEXT
                end
              end
            end
          end
        end
      end
    end
  end
end
