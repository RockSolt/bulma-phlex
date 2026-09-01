# frozen_string_literal: true

module BulmaPhlex
  class Table
    # Internal component for rendering a sortable table header.
    class Sort < BulmaPhlex::Base
      DIRECTIONS = %i[asc desc].freeze

      # **Parameters**
      #
      # - `header_label` — The text to display in the table header
      # - `header_classes` — CSS classes for the `<th>` element
      # - `href` — The URL to navigate to when the header is clicked
      # - `current_direction` — The current sort direction (`:asc`, `:desc`, or `nil`)
      # - `link_attributes` — Additional HTML attributes for the `<a>` element
      def self.new(header_label:, header_classes:, href:, current_direction: nil, link_attributes: {})
        super
      end

      def initialize(header_label:, header_classes:, href:, current_direction: nil, link_attributes: {})
        validate_direction!(current_direction)
        validate_link_attributes!(link_attributes)

        @header_label = header_label
        @header_classes = header_classes
        @href = href
        @direction = current_direction
        @link_attributes = link_attributes
      end

      def view_template
        th(**header_attributes) do
          a(**link_attributes) do
            render Icon.new(icon, text_left: @header_label, nowrap: true, icon_attributes: { aria: { hidden: "true" } })
          end
        end
      end

      def active?
        !@direction.nil?
      end

      def ascending?
        @direction == :asc
      end

      def descending?
        @direction == :desc
      end

      attr_reader :href, :direction

      private

      def header_attributes
        attributes = { class: @header_classes }
        if active?
          attributes[:aria_sort] = ascending? ? "ascending" : "descending"
        end
        attributes
      end

      def link_attributes
        unless @link_attributes[:class]&.include?("has-text-")
          @link_attributes = mix(@link_attributes,
                                 class: "has-text-grey-dark")
        end
        mix(
          @link_attributes,
          href!: @href,
          aria!: mix(@link_attributes.fetch(:aria, {}), label!: link_label)
        )
      end

      def link_label
        label = @header_label.to_s
        return "Sort by #{label}" unless active?

        sort_dir = ascending? ? "ascending" : "descending"
        "#{label}, sorted #{sort_dir}. Activate to change sort order."
      end

      def icon
        return "fas fa-sort-up" if ascending?
        return "fas fa-sort-down" if descending?

        "fas fa-sort"
      end

      def validate_direction!(value)
        return if value.nil? || DIRECTIONS.include?(value)

        valid_directions = DIRECTIONS.map { |direction| ":#{direction}" }.join(", ")
        raise ArgumentError, "current_direction must be #{valid_directions}, or nil"
      end

      def validate_link_attributes!(value)
        raise ArgumentError, "link_attributes must be a Hash" unless value.is_a?(Hash)
      end
    end

    private_constant :Sort
  end
end
