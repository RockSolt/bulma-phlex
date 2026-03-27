# frozen_string_literal: true

module Playground
  module Sections
    class Pagination < Phlex::HTML
      MockPager = Struct.new(:current_page, :total_pages, :per_page, :total_count) do
        def previous_page
          current_page > 1 ? current_page - 1 : nil
        end

        def next_page
          current_page < total_pages ? current_page + 1 : nil
        end
      end

      def view_template
        h2(class: "title is-4") { "Pagination" }

        h3(class: "label") { "Multiple Pages (Middle)" }
        div(class: "mb-5") do
          pager = MockPager.new(5, 10, 20, 200)
          path_builder = ->(page) { "/posts?page=#{page}" }
          render BulmaPhlex::Pagination.new(pager, path_builder)
        end

        h3(class: "label") { "First Page (Previous Disabled)" }
        div(class: "mb-5") do
          pager = MockPager.new(1, 5, 10, 45)
          path_builder = ->(page) { "/posts?page=#{page}" }
          render BulmaPhlex::Pagination.new(pager, path_builder)
        end

        h3(class: "label") { "Last Page (Next Disabled)" }
        div(class: "mb-5") do
          pager = MockPager.new(5, 5, 10, 45)
          path_builder = ->(page) { "/posts?page=#{page}" }
          render BulmaPhlex::Pagination.new(pager, path_builder)
        end

        h3(class: "label") { "Single Page (Nothing Rendered)" }
        div(class: "mb-5") do
          pager = MockPager.new(1, 1, 10, 5)
          path_builder = ->(page) { "/posts?page=#{page}" }
          render BulmaPhlex::Pagination.new(pager, path_builder)
          p(class: "help is-italic") { "No pagination rendered when there is only one page." }
        end

        h3(class: "label") { "Custom HTML Attributes" }
        div(class: "mb-5") do
          pager = MockPager.new(2, 5, 10, 45)
          path_builder = ->(page) { "/posts?page=#{page}" }
          render BulmaPhlex::Pagination.new(pager, path_builder, class: "custom-pagination", data_test: "pagination")
        end
      end
    end
  end
end
