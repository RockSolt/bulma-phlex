# frozen_string_literal: true

module BulmaPhlex
  # Renders a [Bulma button](https://bulma.io/documentation/elements/button/) element.
  #
  # The component can generate a `<button>`, `<a>`, or `<input>` element depending on the
  # arguments provided. Supports Bulma options for **color**, **size**, **style mode**,
  # and **layout** (responsive, fullwidth, outlined, inverted, rounded), as well as
  # optional **icons** on the left and/or right side of the label.
  #
  # The label can be passed into the component as a string or from a block.
  class Button < Base
    # Returns an array of CSS classes for the button based on the provided options.
    def self.classes_for(color: nil, # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
                         mode: nil,
                         size: nil,
                         responsive: false,
                         fullwidth: false,
                         outlined: false,
                         inverted: false,
                         rounded: false)
      classes = ["button"]
      classes << "is-#{color}" if color
      classes << "is-#{mode}" if mode
      classes << "is-#{size}" if size
      classes << "is-responsive" if responsive
      classes << "is-fullwidth" if fullwidth
      classes << "is-outlined" if outlined
      classes << "is-inverted" if inverted
      classes << "is-rounded" if rounded
      classes
    end

    # **Parameters**
    #
    # - `label` (positional) — Optionally pass in button label as a string
    # - `color` — Button color: `"primary"`, `"link"`, `"info"`, `"success"`, `"warning"`, `"danger"`
    # - `mode` — Button style mode: `"light"` or `"dark"`
    # - `size` — Button size: `"small"`, `"normal"`, `"medium"`, `"large"`
    # - `responsive` — If `true`, makes the button responsive
    # - `fullwidth` — If `true`, makes the button full width
    # - `outlined` — If `true`, renders the button outlined
    # - `inverted` — If `true`, renders the button inverted
    # - `rounded` — If `true`, renders the button rounded
    # - `icon` — Icon class added to the button (e.g. `"fa-solid fa-check"`); shorthand for `icon_left`
    # - `icon_left` — Icon class added to the left of the button text
    # - `icon_right` — Icon class added to the right of the button text
    # - `input` — If set, renders an `<input>` element of this type (`"button"`, `"reset"`, `"submit"`)
    # - `**html_attributes` — Additional HTML attributes for the button element
    def self.new(label = nil,
                 color: nil,
                 mode: nil,
                 size: nil,
                 responsive: false,
                 fullwidth: false,
                 outlined: false,
                 inverted: false,
                 rounded: false,
                 icon: nil,
                 icon_left: nil,
                 icon_right: nil,
                 input: nil,
                 **html_attributes)
      super
    end

    def initialize(label = nil,
                   color: nil,
                   mode: nil,
                   size: nil,
                   responsive: false,
                   fullwidth: false,
                   outlined: false,
                   inverted: false,
                   rounded: false,
                   icon: nil,
                   icon_left: nil,
                   icon_right: nil,
                   input: nil,
                   **html_attributes)
      @label = label
      @classes = self.class.classes_for(color:, mode:, size:, responsive:, fullwidth:, outlined:, inverted:, rounded:)
      @input = input
      @icon_left = icon || icon_left
      @icon_right = icon_right
      @html_attributes = html_attributes
    end

    def view_template(&)
      block_content = capture(&)

      options = mix({ class: @classes }, @html_attributes)

      if @input
        input(**options, type: @input)
      else
        element_type = @html_attributes.key?(:href) ? :a : :button
        tag(element_type, **options) do
          Icon(@icon_left) if @icon_left
          button_label(block_content)
          Icon(@icon_right) if @icon_right
        end
      end
    end

    private

    def button_label(block_content)
      value = @label || block_content
      return if value.nil? || value.empty?

      if @icon_left || @icon_right
        span { value }
      else
        plain value
      end
    end
  end
end
