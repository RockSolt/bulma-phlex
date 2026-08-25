# frozen_string_literal: true

require "test_helper"

module BulmaPhlex
  class Table
    class SortTest < ActiveSupport::TestCase
      def test_defaults_to_an_inactive_sort
        sort = Sort.new(href: "/widgets?filter[sort]=name")

        assert_equal "/widgets?filter[sort]=name", sort.href
        assert_nil sort.direction

        assert_not_predicate sort, :active?
        assert_not_predicate sort, :ascending?
        assert_not_predicate sort, :descending?
        assert_equal({}, sort.link_attributes)
        assert_nil sort.aria_label
      end

      def test_freezes_the_sort_and_link_attributes_by_default
        sort = Sort.new(href: "/widgets?filter[sort]=name")

        assert_predicate sort, :frozen?
        assert_predicate sort.link_attributes, :frozen?
      end

      def test_reports_an_active_ascending_sort
        sort = Sort.new(href: "/widgets?filter[sort]=-name", direction: :ascending)

        assert_predicate sort, :active?
        assert_predicate sort, :ascending?
        assert_not_predicate sort, :descending?
      end

      def test_reports_an_active_descending_sort
        sort = Sort.new(href: "/widgets?filter[sort]=name", direction: :descending)

        assert_predicate sort, :active?
        assert_not_predicate sort, :ascending?
        assert_predicate sort, :descending?
      end

      def test_preserves_link_attributes_and_accessible_label
        attributes = { data: { turbo_frame: "widgets" }, class: "has-text-link" }
        sort = Sort.new(href: "/widgets?filter[sort]=name", link_attributes: attributes, aria_label: "Sort widgets")

        assert_equal attributes, sort.link_attributes
        assert_equal "Sort widgets", sort.aria_label
      end

      def test_rejects_an_unknown_current_direction
        error = assert_raises(ArgumentError) do
          Sort.new(href: "/widgets", direction: :sideways)
        end

        assert_equal "direction must be :ascending, :descending, or nil", error.message
      end

      def test_normalizes_the_aria_container_key
        sort = Sort.new(href: "/widgets?filter[sort]=name", link_attributes: { "aria" => { describedby: "sort-help" } })

        assert_equal({ aria: { describedby: "sort-help" } }, sort.link_attributes)
      end

      def test_rejects_component_owned_link_attributes
        {
          href: "/incorrect",
          "aria-label" => "Caller label"
        }.each do |attribute, value|
          error = assert_raises(ArgumentError) do
            Sort.new(href: "/widgets", link_attributes: { attribute => value })
          end

          assert_equal "link_attributes must not include #{attribute.to_s.tr("-", "_").to_sym.inspect}", error.message
        end
      end

      def test_rejects_component_owned_nested_aria_label
        error = assert_raises(ArgumentError) do
          Sort.new(href: "/widgets", link_attributes: { aria: { label: "Caller label" } })
        end

        assert_equal "link_attributes[:aria] must not include :label", error.message
      end

      def test_requires_hash_link_attributes
        error = assert_raises(ArgumentError) do
          Sort.new(href: "/widgets", link_attributes: "has-text-link")
        end

        assert_equal "link_attributes must be a Hash", error.message
      end
    end
  end
end
