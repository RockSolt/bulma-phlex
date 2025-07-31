# frozen_string_literal: true

require "test_helper"

module Components
  module Bulma
    class TableTest < Minitest::Test
      include TagOutputAssertions

      # Define a simple Data class for our test records with model_name support
      TestRecord = Data.define(:id, :name, :email) do
        # Add model_name support for Rails-style record identification
        def model_name
          Struct.new(:singular, :plural, :param_key).new(
            "test_record",
            "test_records",
            "test_record"
          )
        end
      end

      def test_renders_table_with_columns
        # Create mock data using Data class
        rows = [
          TestRecord.new(id: 1, name: "John Doe", email: "john@example.com"),
          TestRecord.new(id: 2, name: "Jane Smith", email: "jane@example.com")
        ]

        component = Components::Bulma::Table.new(rows)

        raw_result = component.call do |table|
          table.column("ID", &:id)
          table.column("Name", &:name)
          table.column("Email", &:email)
        end

        # Format the result for readable assertions and debugging
        result = format_html(raw_result)

        # Check for key elements in the rendered table
        assert_html_includes result, '<table id="test_records"'
        assert_html_includes result, "<th>ID</th>"
        assert_html_includes result, "<th>Name</th>"
        assert_html_includes result, "<th>Email</th>"
        assert_html_includes result, "<td>1</td>"
        assert_html_includes result, "<td>John Doe</td>"
        assert_html_includes result, "<td>jane@example.com</td>"
      end

      def test_renders_empty_table
        component = Components::Bulma::Table.new([])

        raw_result = component.call do |table|
          table.column("Name", &:name)
          table.column("Email", &:email)
        end

        # Format the result for readable assertions and debugging
        result = format_html(raw_result)

        # Check for headers but no rows
        assert_html_includes result, "<th>Name</th>"
        assert_html_includes result, "<th>Email</th>"
        assert_html_includes result, "<tbody>"
        refute_includes result, "<tr>"
      end

      def test_renders_with_string_id
        rows = [TestRecord.new(id: nil, name: "Test", email: nil)]
        component = Components::Bulma::Table.new(rows, "custom-table-id")

        raw_result = component.call do |table|
          table.column("Name", &:name)
        end

        assert_html_includes format_html(raw_result), 'id="custom-table-id"'
      end

      def test_renders_with_id_option
        rows = [TestRecord.new(id: nil, name: "Test", email: nil)]
        component = Components::Bulma::Table.new(rows, id: "custom-table-id")
        raw_result = component.call { |table| table.column("Name", &:name) }

        assert_html_includes format_html(raw_result), 'id="custom-table-id"'
      end

      def test_bordered_table
        rows = [TestRecord.new(id: nil, name: "Test", email: nil)]
        component = Components::Bulma::Table.new(rows, bordered: true)
        raw_result = component.call { |table| table.column("Name", &:name) }

        assert_html_includes format_html(raw_result), 'class="table is-bordered"'
      end

      def test_striped_table
        component = Components::Bulma::Table.new([], striped: true)
        raw_result = component.call { |table| table.column("Name", &:name) }

        assert_html_includes format_html(raw_result), 'class="table is-striped"'
      end

      def test_narrow_table
        component = Components::Bulma::Table.new([], narrow: true)
        raw_result = component.call { |table| table.column("Name", &:name) }

        assert_html_includes format_html(raw_result), 'class="table is-narrow"'
      end

      def test_hoverable_table
        component = Components::Bulma::Table.new([], hoverable: true)
        raw_result = component.call { |table| table.column("Name", &:name) }

        assert_html_includes format_html(raw_result), 'class="table is-hoverable"'
      end

      def test_fullwidth_table
        component = Components::Bulma::Table.new([], fullwidth: true)
        raw_result = component.call { |table| table.column("Name", &:name) }

        assert_html_includes format_html(raw_result), 'class="table is-fullwidth"'
      end

      def test_combined_classes
        rows = [TestRecord.new(id: nil, name: "Test", email: nil)]
        component = Components::Bulma::Table.new(rows, bordered: true, striped: true, narrow: true)
        raw_result = component.call { |table| table.column("Name", &:name) }

        assert_html_includes format_html(raw_result), 'class="table is-bordered is-striped is-narrow"'
      end
    end
  end
end
