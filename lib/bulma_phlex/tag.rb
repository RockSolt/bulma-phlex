# frozen_string_literal: true

module BulmaPhlex
  # # Tag
  #
  # The Tag component is a bit of a chameleon. It can generate a `span`, `a`, or `button` element
  # based on the provided attributes. If an `href` attribute is provided, the tag will render as an `a` element. If
  # the `delete` option is true or a `data-action` attribute is present, it will render as a `button` element.
  #  Otherwise, it defaults to a `span` element.
  #
  # ## Options
  #
  # - `delete`: If true, adds a delete button inside the tag.
  # - `color`: Sets the [color of the tag](https://bulma.io/documentation/elements/tag/#colors)
  # - `light`: To use a light version of the color, use the key `light` instead of `color`.
  # - `size`: Sets the [size of the tag](https://bulma.io/documentation/elements/tag/#sizes): normal, medium, or large.
  # - `rounded`: If true, adds the `is-rounded` class to the tag.
  #
  # ## HTML Attributes
  #
  # Any additional HTML attributes provided will be applied to the rendered element.
  class Tag < BulmaPhlex::Base
    TAG_OPTIONS = %i[delete color light size rounded].freeze

    def initialize(text, **options_and_html_attributes)
      @text = text
      @html_attributes = options_and_html_attributes.except(*TAG_OPTIONS)
      @options = options_and_html_attributes.slice(*TAG_OPTIONS)
    end

    def view_template
      if @html_attributes.key?(:href)
        a(class: tag_classes, **@html_attributes) { text_and_optional_delete_button }
      elsif @options[:delete] || @html_attributes.dig(:data, :action).present?
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
      classes << "is-#{@options[:color]}" if @options[:color].present?
      classes << "is-#{@options[:light]} is-light" if @options[:light]
      classes << "is-#{@options[:size]}" if @options[:size].present?
      classes << "is-rounded" if @options[:rounded]
      classes.join(" ")
    end
  end
end
