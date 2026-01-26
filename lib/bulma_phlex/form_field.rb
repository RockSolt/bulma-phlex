# frozen_string_literal: true

module BulmaPhlex
  # # Form Field Component
  #
  # The Bulma Form Field is a `field` container that groups a label with yielded content
  # (usually an input). It can optionally include a help text.
  #
  # The label can be provided either as a string argument to the `label` method or as a
  # block. If a string is provided, it will be rendered inside a `<label>` tag with the
  # `label` class. The label can also be omitted entirely if not needed.
  #
  # ## Icons
  #
  # The component supports optional left and right icons within the input control. Specify
  # icons with the `icon_left` and `icon_right` keyword arguments.
  #
  # ```ruby
  # FormField(icon_left: "fas fa-user", icon_right: "fas fa-check")
  # ```
  #
  # ## Column Layout
  #
  # If the form field is to be used within a Bulma column layout, you can specify the `column`
  # keyword. There are three ways to use this:
  # - `true`: makes the field a column without specific sizing.
  # - a size string (e.g., `"half"`): makes the field a column with that size for all breakpoints.
  # - a hash mapping breakpoints to sizes (e.g., `{ mobile: "full", desktop: "half" }`): makes the
  #   field a column with sizes specific to breakpoints
  #
  # ## Example Usage
  #
  # Here is the label provided as a block:
  #
  # ```ruby
  # FormField(help: "Enter the project name.") do |field|
  #   field.label { label "Project Name" }
  #   field.input { input id: "project_name", name: "project[name]", type: "text" }
  # end
  # ```
  #
  # Here is the label provided as a string:
  #
  # ```ruby
  # FormField(help: "Enter the project name.") do |field|
  #   field.label "Project Name"
  #   field.input { input id: "project_name", name: "project[name]", type: "text" }
  # end
  # ```
  #
  # Here is no label provided:
  #
  # ```ruby
  # FormField(help: "Enter the project name.") do |field|
  #   field.input { input id: "project_name", name: "project[name]", type: "text" }
  # end
  # ```
  #
  # ## References
  #
  # - [Bulma Form Field](https://bulma.io/documentation/form/general/#form-field)
  #   - [With Icons](https://bulma.io/documentation/form/general/#with-icons)
  # - [Columns](https://bulma.io/documentation/columns/basics/)
  # - [Grid Cells](https://bulma.io/documentation/grid/grid-cells/)
  class FormField < Phlex::HTML
    def initialize(help: nil, icon_left: nil, icon_right: nil, column: nil, grid: nil)
      @help = help
      @icon_left = icon_left
      @icon_right = icon_right
      @column = column
      @grid = grid
    end

    # in order to use the method name `label`, we need to grab a reference to the method on the base class
    # so it is stil available to us
    alias html_label label

    def label(label_string = nil, &block)
      @label_string = label_string
      @label_builder = block
    end

    def control(&block)
      @control_builder = block
    end

    def view_template(&)
      vanish(&)

      div(class: field_classes) do
        render_label
        render FormControl.new(class: control_classes) do
          raw @control_builder.call
          Icon(@icon_left, size: :small, left: true) if @icon_left
          Icon(@icon_right, size: :small, right: true) if @icon_right
        end
        p(class: "help") { @help } if @help
      end
    end

    private

    def field_classes
      [:field].tap do |classes|
        classes.append(column_classes) if @column
        classes.append(grid_classes) if @grid
      end
    end

    def column_classes
      [:column].tap do |classes|
        if @column.is_a?(String) || @column.is_a?(Integer)
          classes << "is-#{@column}"
        elsif @column.is_a?(Hash)
          @column.each do |breakpoint, size|
            classes << "is-#{size}-#{breakpoint}"
          end
        end
      end
    end

    def grid_classes
      if @grid.is_a?(String)
        [:cell, "is-#{@grid}"]
      else
        [:cell]
      end
    end

    def render_label
      if @label_string
        html_label(class: "label") { @label_string }
      elsif @label_builder
        raw @label_builder&.call
      end
    end

    def control_classes
      [].tap do |classes|
        classes << "has-icons-left" if @icon_left
        classes << "has-icons-right" if @icon_right
      end
    end
  end
end
