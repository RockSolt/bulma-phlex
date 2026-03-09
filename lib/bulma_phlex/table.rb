# frozen_string_literal: true

module BulmaPhlex
  # Renders the [Bulma table](https://bulma.io/documentation/elements/table/) component.
  #
  # Displays a collection of records in rows and columns. Columns are defined via the `column`,
  # `date_column`, and `conditional_icon` builder methods. Supports Bulma **style** options
  # (bordered, striped, hoverable) and **layout** options (narrow, fullwidth). An optional
  # **pagination** control can be added to the table footer via the `paginate` method.
  #
  # ## Example
  #
  #     users = User.all
  #
  #     render BulmaPhlex::Table.new(users) do |table|
  #       table.column "Name" do |user|
  #         user.full_name
  #       end
  #
  #       table.column "Email" do |user|
  #         user.email
  #       end
  #
  #       table.column "Actions" do |user|
  #         link_to "Edit", edit_user_path(user), class: "button is-small"
  #       end
  #     end
  class Table < BulmaPhlex::Base
    # **Parameters**
    #
    # - `rows` — The collection of records to display in the table
    # - `bordered` — If `true`, adds borders to the table
    # - `striped` — If `true`, adds zebra-striping to the table rows
    # - `narrow` — If `true`, makes the table more compact
    # - `hoverable` — If `true`, adds a hover effect to the table rows
    # - `fullwidth` — If `true`, makes the table take up the full width of its container
    # - `**html_attributes` — Additional HTML attributes for the `<table>` element
    def self.new(rows,
                 bordered: false,
                 striped: false,
                 narrow: false,
                 hoverable: false,
                 fullwidth: false,
                 **html_attributes)
      super
    end

    def initialize(rows,
                   bordered: false,
                   striped: false,
                   narrow: false,
                   hoverable: false,
                   fullwidth: false,
                   **html_attributes)
      @rows = rows
      @bordered = bordered
      @striped = striped
      @narrow = narrow
      @hoverable = hoverable
      @fullwidth = fullwidth
      @html_attributes = html_attributes
      @columns = []
    end

    def view_template(&)
      vanish(&)

      table(**mix({ class: table_classes }, @html_attributes)) do
        thead do
          @columns.each do |column|
            table_header(column)
          end
        end

        tbody do
          @rows.each do |row|
            tr do
              @columns.each do |column|
                td(**column[:html_attributes]) { column[:content].call(row) }
              end
            end
          end
        end

        pagination
      end
    end

    # Adds a column to the table. Can be called multiple times to define all columns.
    #
    # - `header` — The column header text
    # - `**html_attributes` — Additional HTML attributes for each `<td>` cell in this column
    #
    # Expects a block that receives each `row` object and returns the cell content.
    def column(header, **html_attributes, &content)
      @columns << { header:, html_attributes:, content: }
    end

    # Adds a date-formatted column to the table. Can be called multiple times.
    #
    # - `header` — The column header text
    # - `format` — A `strftime` format string for the date value (default: `"%Y-%m-%d"`)
    # - `**html_attributes` — Additional HTML attributes for each `<td>` cell in this column
    #
    # Expects a block that receives each `row` object and returns a `Date` or `Time` value.
    def date_column(header, format: "%Y-%m-%d", **html_attributes, &content)
      column(header, **html_attributes) do |row|
        content.call(row)&.strftime(format)
      end
    end

    # Adds a column that displays an icon when the block returns a truthy value. Can be called multiple times.
    #
    # - `header` — The column header text
    # - `icon_class` — The CSS class(es) for the icon element (default: `"fas fa-check"`)
    # - `**html_attributes` — Additional HTML attributes for each `<td>` cell in this column
    #
    # Expects a block that receives each `row` object and returns a truthy or falsy value.
    def conditional_icon(header, icon_class: "fas fa-check", **html_attributes, &content)
      html_attributes[:class] = [html_attributes[:class], "has-text-centered"].compact.join(" ")

      column(header, **html_attributes) do |row|
        Icon(icon_class) if content.call(row)
      end
    end

    # Adds a pagination control to the table footer.
    #
    # Expects a block used as the path builder for pagination links. The block receives a page
    # number and should return the URL for that page.
    def paginate(&path_builder)
      @path_builder = path_builder
    end

    private

    def table_classes
      classes = ["table"]
      classes << "is-bordered" if @bordered
      classes << "is-striped" if @striped
      classes << "is-narrow" if @narrow
      classes << "is-hoverable" if @hoverable
      classes << "is-fullwidth" if @fullwidth
      classes
    end

    # this derives a th class from the column html attributes
    # perhaps a better way would be pre-defined pairs?
    def table_header(column)
      attributes = {}
      attributes[:class] = header_alignment(column[:html_attributes])
      th(**attributes) { column[:header] }
    end

    def header_alignment(html_attributes)
      classes = html_attributes[:class]
      return if classes.nil?

      if classes&.include?("has-text-right") || classes&.include?("amount-display")
        "has-text-right"
      elsif classes&.include?("has-text-centered")
        "has-text-centered"
      end
    end

    def pagination
      return unless @path_builder

      tfoot do
        tr do
          td(class: "py-0", colspan: @columns.size) do
            Pagination(@rows, @path_builder, class: "mt-5")
          end
        end
      end
    end
  end
end
