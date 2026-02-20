# frozen_string_literal: true

require "test_helper"

module BulmaPhlex
  class FileUploadTest < Minitest::Test
    include TagOutputAssertions

    Input = Class.new(Phlex::HTML) do
      def initialize(data_attributes)
        super()
        @data_attributes = data_attributes
      end

      def view_template
        input(name: "test_input", type: "file", data: @data_attributes)
      end
    end

    def test_renders_basic_file_upload
      component = BulmaPhlex::FileUpload.new
      result = component.call do |data_attributes|
        Input.call(data_attributes).extend(Phlex::SGML::SafeObject)
      end

      assert_html_equal <<~HTML, result
        <div class="file">
          <label class="file-label">
            <input name="test_input" type="file" />
            <span class="file-cta">
              <span class="file-icon">
                <i class="fas fa-upload"></i>
              </span>
              <span class="file-label"> Choose a file… </span>
            </span>
          </label>
        </div>
      HTML
    end

    def test_with_name
      component = BulmaPhlex::FileUpload.new(name: true)
      result = component.call do |data_attributes|
        Input.call(data_attributes).extend(Phlex::SGML::SafeObject)
      end

      assert_html_equal <<~HTML, result
        <div class="file has-name" data-controller="bulma-phlex--file-input-display">
          <label class="file-label">
            <input name="test_input" type="file" data-bulma-phlex--file-input-display-target="fileInput" data-action="bulma-phlex--file-input-display#show" />
            <span class="file-cta">
              <span class="file-icon">
                <i class="fas fa-upload"></i>
              </span>
              <span class="file-label"> Choose a file… </span>
            </span>
            <span class="file-name is-flex" data-bulma-phlex--file-input-display-target="fileList">No file uploaded</span>
          </label>
        </div>
      HTML
    end

    def test_with_color
      component = BulmaPhlex::FileUpload.new(color: "primary")
      result = component.call do |data_attributes|
        Input.call(data_attributes).extend(Phlex::SGML::SafeObject)
      end

      assert_html_equal <<~HTML, result
        <div class="file is-primary">
          <label class="file-label">
            <input name="test_input" type="file" />
            <span class="file-cta">
              <span class="file-icon">
                <i class="fas fa-upload"></i>
              </span>
              <span class="file-label"> Choose a file… </span>
            </span>
          </label>
        </div>
      HTML
    end

    def test_with_size
      component = BulmaPhlex::FileUpload.new(size: "large")
      result = component.call do |data_attributes|
        Input.call(data_attributes).extend(Phlex::SGML::SafeObject)
      end

      assert_html_includes result, 'class="file is-large"'
    end

    def test_align_right
      component = BulmaPhlex::FileUpload.new(align: "right")
      result = component.call do |data_attributes|
        Input.call(data_attributes).extend(Phlex::SGML::SafeObject)
      end

      assert_html_includes result, 'class="file is-right"'
    end

    def test_fullwidth
      component = BulmaPhlex::FileUpload.new(fullwidth: true)
      result = component.call do |data_attributes|
        Input.call(data_attributes).extend(Phlex::SGML::SafeObject)
      end

      assert_html_includes result, 'class="file is-fullwidth"'
    end

    def test_boxed
      component = BulmaPhlex::FileUpload.new(boxed: true)
      result = component.call do |data_attributes|
        Input.call(data_attributes).extend(Phlex::SGML::SafeObject)
      end

      assert_html_includes result, 'class="file is-boxed"'
    end
  end
end
