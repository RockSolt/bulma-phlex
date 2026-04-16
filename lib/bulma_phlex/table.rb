# frozen_string_literal: true

module BulmaPhlex
  # Renders the [Bulma table](https://bulma.io/documentation/elements/table/) component.
  #
  # Displays a collection of records in rows and columns. Columns are defined via the `column`,
  # `date_column`, and `conditional_icon` builder methods. Supports Bulma **style** options
  # (bordered, striped, hoverable) and **layout** options (narrow, fullwidth). An optional
  # **pagination** control can be added to the table footer via the `paginate` method.
  #
  # The `tr` elements can be customized with the `row` method, which accepts static HTML attributes
  # and/or a block that generates dynamic attributes based on the row data.
  #
  # To make the table responsive, use the `hidden` argument to hide certain columns on smaller
  # screens. See the [Bulma documentation](https://bulma.io/documentation/helpers/visibility-helpers/#hide)
  # for the full list, but the most common options are `hidden: "mobile"` and `hidden: "touch"`.
  #
  # The table supports any additional HTML attributes on the `<table>` element, such as `id` or `data-*`
  # attributes, via the `**html_attributes` argument in the constructor.
  #
  # ## Example
  #
  #     users = User.all
  #
  #     render BulmaPhlex::Table.new(users) do |table|
  #       table.row(class: "has-background-light") { |user| { id: "user-row-#{user.id}" } }
  #       table.column("Name", &:full_name)
  #       table.column("Email", hidden: "touch", &:email)
  #       table.date_column("Joined", hidden: "mobile", &:created_at, format: "%B %d, %Y")
  #       table.conditional_icon("Admin?", &:admin?)
  #       table.column "Actions" do |user|
  #         link_to "Edit", edit_user_path(user), class: "button is-small"
  #       end
  #     end
  class Table < BulmaPhlex::Base # rubocop:disable Metrics/ClassLength
    # Returns an array of CSS classes for the table based on the provided options.
    def self.classes_for(bordered: false, striped: false, narrow: false, hoverable: false, fullwidth: false)
      classes = ["table"]
      classes << "is-bordered" if bordered
      classes << "is-striped" if striped
      classes << "is-narrow" if narrow
      classes << "is-hoverable" if hoverable
      classes << "is-fullwidth" if fullwidth
      classes
    end

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
      @table_classes = self.class.classes_for(bordered:, striped:, narrow:, hoverable:, fullwidth:)
      @html_attributes = html_attributes
      @columns = []
    end

    def view_template(&)
      vanish(&)

      table(**mix({ class: @table_classes }, @html_attributes)) do
        thead do
          @columns.each { |column| table_header(column) }
        end

        tbody do
          @rows.each do |row|
            tr(**table_row_html_attributes(row)) do
              @columns.each { |column| table_data_cell(column, row) }
            end
          end
        end

        pagination
      end
    end

    def row(**html_attributes, &attribute_builder)
      @row_attributes = html_attributes
      @row_attribute_builder = attribute_builder
    end

    # Adds a column to the table. Can be called multiple times to define all columns.
    #
    # - `header` — The column header text
    # - `**html_attributes` — Additional HTML attributes for each `<td>` cell in this column
    #
    # Expects a block that receives each `row` object and returns the cell content.
    def column(header, hidden: false, **html_attributes, &content)
      @columns << { header:, hidden:, html_attributes:, content: }
    end

    # Adds a date-formatted column to the table. Can be called multiple times.
    #
    # - `header` — The column header text
    # - `format` — A `strftime` format string for the date value (default: `"%Y-%m-%d"`)
    # - `**html_attributes` — Additional HTML attributes for each `<td>` cell in this column
    #
    # Expects a block that receives each `row` object and returns a `Date` or `Time` value.
    def date_column(header, hidden: false, format: "%Y-%m-%d", **html_attributes, &content)
      column(header, hidden:, **html_attributes) do |row|
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
    def conditional_icon(header, hidden: false, icon_class: "fas fa-check", **html_attributes, &content)
      html_attributes[:class] = [html_attributes[:class], "has-text-centered"].compact.join(" ")

      column(header, hidden:, **html_attributes) do |row|
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

    def table_header(column)
      th(class: header_classes(column)) { column[:header] }
    end

    def header_classes(column)
      classes = []
      classes << "is-hidden-#{column[:hidden]}" if column[:hidden]
      classes << header_alignment(column[:html_attributes])
      classes.compact
    end

    def header_alignment(html_attributes)
      classes = html_attributes[:class]
      return if classes.nil?

      if classes.include?("has-text-right") || classes.include?("amount-display")
        "has-text-right"
      elsif classes.include?("has-text-centered")
        "has-text-centered"
      end
    end

    def table_row_html_attributes(row)
      attributes = @row_attributes || {}
      if @row_attribute_builder
        dynamic_attributes = @row_attribute_builder.call(row) || {}
        attributes = attributes.merge(dynamic_attributes)
      end
      attributes
    end

    def table_data_cell(column, row)
      td(**mix({ class: cell_classes(column) }, column[:html_attributes])) do
        column[:content].call(row)
      end
    end

    def cell_classes(column)
      return unless column[:hidden]

      "is-hidden-#{column[:hidden]}"
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
