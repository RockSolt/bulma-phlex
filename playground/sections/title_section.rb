# frozen_string_literal: true

module Playground
  module Sections
    class Title < Phlex::HTML
      def view_template
        h2(class: "title is-4") { "Title" }

        p(class: "content") do
          plain "Renders a Bulma title element with an optional subtitle. The "
          code { "size:" }
          plain " option controls the CSS class (not the HTML element — it always renders "
          code { "h1" }
          plain "). The subtitle size defaults to "
          code { "size + 2" }
          plain " when "
          code { "size:" }
          plain " is set."
        end

        h3(class: "subtitle is-5") { "Sizes" }
        div(class: "mb-5") do
          render BulmaPhlex::Title.new("Size 1 (default)", size: 1)
          render BulmaPhlex::Title.new("Size 2", size: 2)
          render BulmaPhlex::Title.new("Size 3", size: 3)
          render BulmaPhlex::Title.new("Size 4", size: 4)
          render BulmaPhlex::Title.new("Size 5", size: 5)
          render BulmaPhlex::Title.new("Size 6", size: 6)
        end

        h3(class: "subtitle is-5") { "With Subtitle (auto subtitle_size)" }
        div(class: "mb-5") do
          render BulmaPhlex::Title.new("Section Title", size: 3, subtitle: "Subtitle defaults to is-5 when size is 3")
        end

        h3(class: "subtitle is-5") { "With Explicit subtitle_size" }
        div(class: "mb-5") do
          render BulmaPhlex::Title.new("Custom Subtitle Size", size: 2, subtitle: "Subtitle forced to is-6",
                                                               subtitle_size: 6)
        end

        h3(class: "subtitle is-5") { "Spaced (increases gap between title and subtitle)" }
        div(class: "mb-5") do
          render BulmaPhlex::Title.new("Spaced Title", spaced: true,
                                                       subtitle: "There is extra space above this subtitle")
        end

        h3(class: "subtitle is-5") { "No Subtitle" }
        div(class: "mb-5") do
          render BulmaPhlex::Title.new("Title Only")
        end
      end
    end
  end
end
