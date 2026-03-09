# frozen_string_literal: true

module BulmaPhlex
  # Renders a responsive grid layout using [Bulma's grid system](https://bulma.io/documentation/grid/).
  #
  class Grid < BulmaPhlex::Base
    # **Parameters**
    # - `fixed_columns` — Specifies a fixed number of columns for the grid
    # - `auto_count` — If `true`, the grid will automatically adjust the number of columns based on the content
    # - `minimum_column_width` — Sets a minimum column width (integer 1-32)
    # - `gap` — Sets the gap size between grid items (1-8 with 0.5 increments)
    # - `column_gap` — Sets the column gap size between grid items (1-8 with 0.5 increments)
    # - `row_gap` — Sets the row gap size between grid items (1-8 with 0.5 increments)
    # - `**html_attributes` — Additional HTML attributes for the grid element
    def self.new(fixed_columns: nil,
                 auto_count: false,
                 minimum_column_width: nil,
                 gap: nil,
                 column_gap: nil,
                 row_gap: nil,
                 **html_attributes)
      super
    end

    def initialize(fixed_columns: nil,
                   auto_count: false,
                   minimum_column_width: nil,
                   gap: nil,
                   column_gap: nil,
                   row_gap: nil,
                   **html_attributes)
      @fixed_columns = fixed_columns
      @auto_count = auto_count
      @minimum_column_width = minimum_column_width
      @gap = gap
      @column_gap = column_gap
      @row_gap = row_gap
      @html_attributes = html_attributes
    end

    def view_template(&)
      optional_fixed_grid_wrapper do
        div(**mix({ class: grid_classes }, @html_attributes), &)
      end
    end

    private

    def optional_fixed_grid_wrapper(&)
      if @fixed_columns || @auto_count
        div(**mix({ class: fixed_grid_classes }, @html_attributes)) do
          @html_attributes = {}
          yield
        end
      else
        yield
      end
    end

    def grid_classes
      classes = ["grid"]
      classes << "is-col-min-#{@minimum_column_width}" if @minimum_column_width
      classes << "is-gap-#{@gap}" if @gap
      classes << "is-column-gap-#{@column_gap}" if @column_gap
      classes << "is-row-gap-#{@row_gap}" if @row_gap
      classes.join(" ")
    end

    def fixed_grid_classes
      classes = ["fixed-grid"]
      classes << "has-#{@fixed_columns}-cols" if @fixed_columns
      classes << "has-auto-count" if @auto_count
      classes.join(" ")
    end
  end
end
