# frozen_string_literal: true

require "test_helper"

module Components
  module Bulma
    class PaginationTest < Minitest::Test
      include TagOutputAssertions

      # Simple mock for testing pagination
      class MockPager
        attr_reader :current_page, :total_pages, :per_page, :total_count

        def initialize(current_page, total_pages, per_page, total_count)
          @current_page = current_page
          @total_pages = total_pages
          @per_page = per_page
          @total_count = total_count
        end

        def previous_page
          current_page > 1 ? current_page - 1 : nil
        end

        def next_page
          current_page < total_pages ? current_page + 1 : nil
        end
      end

      def test_pagination_with_multiple_pages
        pager = MockPager.new(5, 10, 20, 200)
        path_builder = ->(page) { "/posts?page=#{page}" }
        component = BulmaPhlex::Pagination.new(pager, path_builder)

        result = component.call

        # Check for essential pagination elements
        assert_html_includes result, '<nav class="pagination"'
        assert_html_includes result, '<a class="pagination-previous" href="/posts?page=4">Previous</a>'
        assert_html_includes result, '<a class="pagination-next" href="/posts?page=6">Next</a>'
        assert_html_includes result,
                             '<a class="pagination-link is-current" aria-label="Page 5" aria-current="page">5</a>'
        assert_html_includes result, "Showing 81-100 of 200 items"
      end

      def test_pagination_on_first_page
        pager = MockPager.new(1, 5, 10, 45)
        path_builder = ->(page) { "/posts?page=#{page}" }
        component = BulmaPhlex::Pagination.new(pager, path_builder)

        result = component.call

        assert_html_includes result, '<a class="pagination-previous" disabled>Previous</a>'
        assert_html_includes result, '<a class="pagination-next" href="/posts?page=2">Next</a>'
        assert_html_includes result, "Showing 1-10 of 45 items"
      end

      def test_pagination_on_last_page
        pager = MockPager.new(5, 5, 10, 45)
        path_builder = ->(page) { "/posts?page=#{page}" }
        component = BulmaPhlex::Pagination.new(pager, path_builder)

        result = component.call

        assert_html_includes result, '<a class="pagination-previous" href="/posts?page=4">Previous</a>'
        assert_html_includes result, '<a class="pagination-next" disabled>Next</a>'
        assert_html_includes result, "Showing 41-45 of 45 items"
      end

      def test_no_pagination_for_single_page
        pager = MockPager.new(1, 1, 10, 5)
        path_builder = ->(page) { "/posts?page=#{page}" }
        component = BulmaPhlex::Pagination.new(pager, path_builder)

        result = component.call

        assert_empty result
      end
    end
  end
end
