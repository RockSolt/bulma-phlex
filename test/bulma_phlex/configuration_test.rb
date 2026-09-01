# frozen_string_literal: true

require "test_helper"

module BulmaPhlex
  class ConfigurationTest < Minitest::Test
    include TagOutputAssertions

    def setup
      @icons = BulmaPhlex.config.icons
      @defaults = {
        sort: @icons.sort,
        dropdown: @icons.dropdown,
        file_upload: @icons.file_upload,
        conditional: @icons.conditional
      }
    end

    def teardown
      @icons.sort = @defaults[:sort]
      @icons.dropdown = @defaults[:dropdown]
      @icons.file_upload = @defaults[:file_upload]
      @icons.conditional = @defaults[:conditional]
    end

    def test_exposes_default_icon_configuration
      assert_equal({ ascending: "fa-solid fa-sort-up",
                     descending: "fa-solid fa-sort-down",
                     inactive: "fa-solid fa-sort" },
                   @icons.sort)
      assert_equal "fa-solid fa-angle-down", @icons.dropdown
      assert_equal "fa-solid fa-upload", @icons.file_upload
      assert_equal "fa-solid fa-check", @icons.conditional
    end

    def test_applies_configured_sort_icons
      @icons.sort = { ascending: "sort-ascending", descending: "sort-descending", inactive: "sort-inactive" }

      table = Table.new([{ name: "Name" }])
      result = table.call do |rendered_table|
        rendered_table.column("Name", sort: { href: "/users", current_direction: :asc }) { |row| row[:name] }
      end

      assert_includes result, "sort-ascending"
    end

    def test_applies_configured_component_icons
      @icons.dropdown = "dropdown-icon"
      @icons.file_upload = "upload-icon"
      @icons.conditional = "conditional-icon"

      assert_includes Dropdown.new("Actions").call, "dropdown-icon"
      assert_includes FileUpload.new.call { nil }, "upload-icon"

      table = Table.new([{ active: true }])
      result = table.call do |rendered_table|
        rendered_table.conditional_icon("Active") { |row| row[:active] }
      end

      assert_includes result, "conditional-icon"
    end

    def test_per_use_icons_override_configuration
      @icons.sort = { ascending: "configured-ascending", descending: "configured-descending",
                      inactive: "configured-inactive" }

      table = Table.new([{ name: "Name" }])
      result = table.call do |rendered_table|
        rendered_table.column(
          "Name",
          sort: {
            href: "/users",
            current_direction: :asc,
            icons: { ascending: "custom-ascending" }
          }
        ) { |row| row[:name] }
      end

      assert_includes result, "custom-ascending"
      refute_includes result, "configured-ascending"
    end
  end
end
