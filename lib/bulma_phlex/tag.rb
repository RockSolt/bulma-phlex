# frozen_string_literal: true

module BulmaPhlex
  # Renders the [Bulma tag](https://bulma.io/documentation/elements/tag/) component.
  #
  # Generates a `<span>`, `<a>`, or `<button>` element depending on the provided attributes.
  # Supports Bulma options for **color**, **size**, and **shape** (rounded), with an optional
  # **delete button** that can appear inside the tag.
  class Tag < BulmaPhlex::Base
    TAG_OPTIONS = %i[delete color light size rounded].freeze

    # **Parameters**
    #
    # - `text` — The text content of the tag
    # - `delete` — If `true`, adds a delete button inside the tag
    # - `color` — Sets the [color of the tag](https://bulma.io/documentation/elements/tag/#colors)
    # - `light` — To use a light version of the color, use the key `light` instead of `color`
    # - `size` — Sets the [size of the tag](https://bulma.io/documentation/elements/tag/#sizes): `"normal"`,
    # `"medium"`, or `"large"`
    # - `rounded` — If `true`, adds the `is-rounded` class to the tag
    # - `**options_and_html_attributes` — Additional HTML attributes applied to the rendered element
    def self.new(text, **options_and_html_attributes)
      super
    end

    def initialize(text, **options_and_html_attributes)
      @text = text
      @html_attributes = options_and_html_attributes.except(*TAG_OPTIONS)
      @options = options_and_html_attributes.slice(*TAG_OPTIONS)
    end

    def view_template
      if @html_attributes.key?(:href)
        a(class: tag_classes, **@html_attributes) { text_and_optional_delete_button }
      elsif @options[:delete] || !@html_attributes.dig(:data, :action).nil?
        button(class: tag_classes, **@html_attributes) { text_and_optional_delete_button }
      else
        span(class: tag_classes, **@html_attributes) { plain @text }
      end
    end

    private

    def text_and_optional_delete_button
      plain @text
      return unless @options[:delete]

      size = "is-small" unless @options[:size] == "large"
      span(class: "delete #{size}".rstrip)
    end

    def tag_classes
      classes = ["tag"]
      classes << "is-#{@options[:color]}" unless @options[:color].nil?
      classes << "is-#{@options[:light]} is-light" if @options[:light]
      classes << "is-#{@options[:size]}" unless @options[:size].nil?
      classes << "is-rounded" if @options[:rounded]
      classes.join(" ")
    end
  end
end
