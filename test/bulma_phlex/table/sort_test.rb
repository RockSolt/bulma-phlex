# frozen_string_literal: true

require "test_helper"

module BulmaPhlex
  class Table
    class SortTest < ActiveSupport::TestCase
      def test_defaults_to_an_inactive_sort
        sort = Sort.new(header_label: "Name", header_classes: [], href: "/widgets?filter[sort]=name")

        assert_equal "/widgets?filter[sort]=name", sort.href
        assert_nil sort.direction

        assert_not_predicate sort, :active?
        assert_not_predicate sort, :ascending?
        assert_not_predicate sort, :descending?
      end

      def test_reports_an_active_ascending_sort
        sort = Sort.new(
          header_label: "Name",
          header_classes: [],
          href: "/widgets?filter[sort]=-name",
          current_direction: :asc
        )

        assert_predicate sort, :active?
        assert_predicate sort, :ascending?
        assert_not_predicate sort, :descending?
      end

      def test_reports_an_active_descending_sort
        sort = Sort.new(
          header_label: "Name",
          header_classes: [],
          href: "/widgets?filter[sort]=name",
          current_direction: :desc
        )

        assert_predicate sort, :active?
        assert_not_predicate sort, :ascending?
        assert_predicate sort, :descending?
      end

      def test_rejects_an_unknown_current_direction
        error = assert_raises(ArgumentError) do
          Sort.new(header_label: "Name", header_classes: [], href: "/widgets", current_direction: :sideways)
        end

        assert_equal "current_direction must be :asc, :desc, or nil", error.message
      end
    end
  end
end
