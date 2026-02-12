# frozen_string_literal: true

module BulmaPhlex
  # Table component for data display
  #
  # This component implements the [Bulma table](https://bulma.io/documentation/elements/table/)
  # interface, providing a way to display data in rows and columns with customizable
  # headers and formatting options.
  #
  # ## Example
  #
  # ```ruby
  # users = User.all
  #
  # BulmaPhlex::Table(users) do |table|
  #   table.column "Name" do |user|
  #     user.full_name
  #   end
  #
  #   table.column "Email" do |user|
  #     user.email
  #   end
  #
  #   table.column "Actions" do |user|
  #     link_to "Edit", edit_user_path(user), class: "button is-small"
  #   end
  # end
  # ```
  #
  # ## Options
  #
  # - `bordered`: Adds borders to the table.
  # - `striped`: Adds zebra-striping to the table rows.
  # - `narrow`: Makes the table more compact.
  # - `hoverable`: Adds a hover effect to the table rows.
  # - `fullwidth`: Makes the table take up the full width of its container.
  #
  # Any additional HTML attributes passed to the component will be applied to the `<table>` element.
  #
  # ## Pagination
  #
  # If the `paginate` method is called with a block that builds pagination paths, a pagination control
  # will be rendered in the table footer. The block should accept a page number and return the
  # corresponding URL for that page.
  class Table < BulmaPhlex::Base
    def initialize(rows, # rubocop:disable Metrics/ParameterLists
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

    def column(header, **html_attributes, &content)
      @columns << { header:, html_attributes:, content: }
    end

    def date_column(header, format: "%Y-%m-%d", **html_attributes, &content)
      column(header, **html_attributes) do |row|
        content.call(row)&.strftime(format)
      end
    end

    def conditional_icon(header, icon_class: "fas fa-check", **html_attributes, &content)
      html_attributes[:class] = [html_attributes[:class], "has-text-centered"].compact.join(" ")

      column(header, **html_attributes) do |row|
        Icon(icon_class) if content.call(row)
      end
    end

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
