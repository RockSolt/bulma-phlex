# frozen_string_literal: true

module BulmaPhlex
  # # File Upload
  #
  # The file upload component allows you to create a styled file input using Bulma's classes.
  #
  # ## Options
  #
  # - `color`: Sets the color of the file input
  # - `size`: Sets the size of the file input
  # - `name`: If `true`, includes the file name display element
  # - `align`: Aligns the file input: right or centered
  # - `fullwidth`: If `true`, makes the file input full width
  # - `boxed`: If `true`, makes the file input boxed
  # - `data_attributes_builder`: A custom builder for the data attributes used for Stimulus integration. If
  #   not provided, a default builder is used with the controller name "bulma-phlex--file-input-display".
  class FileUpload < Base
    DataAttributesBuilder = Data.define(:for_file, :for_file_input, :for_file_list)

    def self.stimulus_data_attributes(controller)
      DataAttributesBuilder.new(
        for_file: { controller: controller },
        for_file_input: { "#{controller}-target": "fileInput", action: "#{controller}#show" },
        for_file_list: { "#{controller}-target": "fileList" }
      )
    end

    def initialize(color: nil,
                   size: nil,
                   name: false,
                   align: nil,
                   fullwidth: false,
                   boxed: false,
                   data_attributes_builder: nil)
      @color = color
      @size = size
      @name = name
      @align = align
      @fullwidth = fullwidth
      @boxed = boxed

      return unless @name

      @data_attributes_builder = data_attributes_builder ||
                                 self.class.stimulus_data_attributes("bulma-phlex--file-input-display")
    end

    def view_template
      div(class: file_classes, data: @data_attributes_builder&.for_file) do
        label(class: "file-label") do
          yield(@data_attributes_builder&.for_file_input)
          span(class: "file-cta") do
            span(class: "file-icon") do
              i(class: "fas fa-upload")
            end
            span(class: "file-label") { plain " Choose a file… " }
          end
          file_name_span if @name
        end
      end
    end

    private

    def file_classes
      classes = ["file"]
      classes << "is-#{@color}" if @color
      classes << "is-#{@size}" if @size
      classes << "has-name" if @name
      classes << "is-#{@align}" if @align
      classes << "is-fullwidth" if @fullwidth
      classes << "is-boxed" if @boxed
      classes
    end

    def file_name_span
      span(class: "file-name is-flex", data: @data_attributes_builder&.for_file_list) do
        plain "No file uploaded"
      end
    end
  end
end
