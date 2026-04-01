# frozen_string_literal: true

module BulmaPhlex
  # A `field` container that groups a label, control input, and optional help text using
  # the [Bulma form field](https://bulma.io/documentation/form/general/#form-field) pattern.
  #
  # Supports an optional **label** (provided as a string or block via the `label` method),
  # optional **help text**, optional **icons** (left and/or right), and **layout** options for
  # integrating with Bulma's column and grid systems. The form control content is set via the
  # `control` method (or a block passed directly to the component).
  #
  # If the label is passes as a string argument, the any additional html attributes can also be included as arguments.
  #
  # ## References
  #
  # - [Bulma Form Field](https://bulma.io/documentation/form/general/#form-field)
  #   - [With Icons](https://bulma.io/documentation/form/general/#with-icons)
  # - [Columns](https://bulma.io/documentation/columns/basics/)
  # - [Grid Cells](https://bulma.io/documentation/grid/grid-cells/)
  class FormField < Base
    # **Parameters**
    #
    # - `help` — Optional help text displayed below the input
    # - `icon_left` — Icon class for an icon to the left of the input (e.g. `"fas fa-user"`)
    # - `icon_right` — Icon class for an icon to the right of the input (e.g. `"fas fa-check"`)
    # - `column` — If `true`, makes the field a column; a size string (e.g. `"half"`) sets the size for
    #   all breakpoints; a hash (e.g. `{ mobile: "full", desktop: "half" }`) sets responsive sizes
    # - `grid` — If `true`, makes the field a grid cell; a size string sets the cell size
    def self.new(help: nil, icon_left: nil, icon_right: nil, column: nil, grid: nil)
      super
    end

    def initialize(help: nil, icon_left: nil, icon_right: nil, column: nil, grid: nil)
      @help = help
      @icon_left = icon_left
      @icon_right = icon_right
      @column = column
      @grid = grid
    end

    # in order to use the method name `label`, we need to grab a reference to the method on the base class
    # so it is still available to us
    alias html_label label

    # Sets the label for the field.
    #
    # - `label_string` — A plain text label string. If omitted, a block must be provided instead.
    #
    # Optionally expects a block that renders a custom label (e.g. with a link or icon inside).
    # Only one of `label_string` or a block should be provided.
    def label(label_string = nil, **html_attributes, &block)
      @label_string = label_string
      @label_attributes = html_attributes
      @label_builder = block
    end

    # Sets the form control content for the field (e.g. an `<input>`, `<select>`, or `<textarea>`).
    # If not called explicitly, the block passed directly to the component is used as the control.
    #
    # Expects a block that renders the form control element.
    def control(&block)
      @control_builder = block
    end

    def view_template(&implicit_control)
      @control_builder = implicit_control if @control_builder.nil? && implicit_control
      vanish(&implicit_control)

      div(class: field_classes) do
        render_label
        render FormControl.new(icon_left: @icon_left, icon_right: @icon_right) do
          raw @control_builder.call
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
        html_label(**mix({ class: "label" }, **@label_attributes)) { @label_string }
      elsif @label_builder
        raw @label_builder&.call
      end
    end
  end
end
