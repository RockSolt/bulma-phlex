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

      def test_renders_with_custom_id
        rows = [TestRecord.new(id: nil, name: "Test", email: nil)]
        component = Components::Bulma::Table.new(rows, "custom-table-id")

        raw_result = component.call do |table|
          table.column("Name", &:name)
        end

        # Format the result for readable assertions and debugging
        result = format_html(raw_result)

        assert_html_includes result, 'id="custom-table-id"'
      end
    end
  end
end
