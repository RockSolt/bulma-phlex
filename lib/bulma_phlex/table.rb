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
  # Bulma::Table(users) do |table|
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
  class Table < Components::Bulma::Base
    def initialize(rows, id_or_options = nil, **options)
      @rows = rows
      @id, @table_class = parse_id_and_options(id_or_options, options, rows)
      @columns = []
    end

    def view_template(&)
      vanish(&)

      table(id: @id, class: @table_class) do
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
        icon_span(icon_class) if content.call(row)
      end
    end

    def paginate(&path_builder)
      @path_builder = path_builder
    end

    private

    def parse_id_and_options(id_or_options, options, rows)
      if id_or_options.is_a?(String)
        id = id_or_options
        opts = options
      else
        opts = (id_or_options || {}).merge(options)
        id = opts.delete(:id) || id_from_array_or_arel(rows)
      end
      table_class = "table #{parse_table_classes(opts)}"
      [id, table_class]
    end

    def id_from_array_or_arel(rows)
      if rows.respond_to? :model
        rows.model.model_name.plural
      elsif rows.empty?
        "table"
      else
        rows.first.model_name.plural
      end
    rescue StandardError
      "table"
    end

    def parse_table_classes(options)
      options.slice(*%i[bordered striped narrow hoverable fullwidth])
             .transform_keys { |key| "is-#{key}" }
             .select { |_, value| value }
             .keys
             .join(" ")
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
            Pagination(@rows, @path_builder)
          end
        end
      end
    end
  end
end
