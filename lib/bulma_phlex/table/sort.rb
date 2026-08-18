# frozen_string_literal: true

module BulmaPhlex
  class Table
    # Presentation state for a sortable table header.
    #
    # The caller owns the sort semantics and supplies an href for the next sort
    # state. This object only describes how that state should be presented by a
    # table component.
    class Sort
      DIRECTIONS = %i[ascending descending].freeze
      RESERVED_LINK_ATTRIBUTE_KEYS = %i[href aria_label].freeze

      attr_reader :href, :direction, :initial_direction, :link_attributes, :aria_label

      # @param href [String] The URL to link to for the next sort state.
      # @param direction [Symbol, nil] The current sort direction, or nil if not sorted.
      # @param initial_direction [Symbol] The direction to sort when the column is first sorted.
      # @param link_attributes [Hash] Additional HTML attributes to add to the link
      # @param aria_label [String, nil] The aria-label for the link. If not provided, the link will have no aria-label.
      def initialize(href:, direction: nil, initial_direction: :ascending, link_attributes: {}, aria_label: nil)
        validate_direction!(direction, allow_nil: true)
        validate_direction!(initial_direction)
        validate_link_attributes!(link_attributes)

        @href = href
        @direction = direction
        @initial_direction = initial_direction
        @link_attributes = normalize_link_attributes(link_attributes).freeze
        @aria_label = aria_label
        freeze
      end

      def active?
        !@direction.nil?
      end

      def ascending?
        @direction == :ascending
      end

      def descending?
        @direction == :descending
      end

      def next_direction
        return @initial_direction unless active?

        ascending? ? :descending : :ascending
      end

      private

      def validate_direction!(value, allow_nil: false)
        return if value.nil? && allow_nil
        return if DIRECTIONS.include?(value)

        valid_directions = DIRECTIONS.map { |direction| ":#{direction}" }.join(", ")
        raise ArgumentError, "direction must be #{valid_directions}#{", or nil" if allow_nil}"
      end

      def validate_link_attributes!(value)
        raise ArgumentError, "link_attributes must be a Hash" unless value.is_a?(Hash)

        validate_reserved_link_attributes!(value)
        validate_aria_link_attributes!(value)
      end

      def validate_reserved_link_attributes!(attributes)
        reserved_attribute = RESERVED_LINK_ATTRIBUTE_KEYS.find do |key|
          attributes.key?(key) || attributes.key?(key.to_s.tr("_", "-"))
        end
        return unless reserved_attribute

        raise ArgumentError, "link_attributes must not include #{reserved_attribute.inspect}"
      end

      def validate_aria_link_attributes!(attributes)
        aria_attributes = attributes[:aria] || attributes["aria"]
        return unless aria_attributes.is_a?(Hash) && (aria_attributes.key?(:label) || aria_attributes.key?("label"))

        raise ArgumentError, "link_attributes[:aria] must not include :label"
      end

      def normalize_link_attributes(attributes)
        attributes.transform_keys { |key| key == "aria" ? :aria : key }.tap do |normalized_attributes|
          aria_attributes = normalized_attributes[:aria]
          next unless aria_attributes.is_a?(Hash)

          normalized_attributes[:aria] = aria_attributes.transform_keys { |key| key == "label" ? :label : key }
        end
      end
    end
  end
end
