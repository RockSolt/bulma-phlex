# frozen_string_literal: true

module BulmaPhlex
  # Renders a [Bulma icon element](https://bulma.io/documentation/elements/icon/) with optional text and
  # form control positioning.
  #
  # Supports **color** and **size** options, optional **text** to the left or right of the icon,
  # and **positioning** helpers (`left`/`right`) for use inside form controls. When text is provide,
  # the icon and text are wrapped in a container with the `icon-text` class for proper spacing, and
  # the icon includes `aria-hidden="true"` for accessibility.
  #
  # Additional HTML attributes can be passed to the icon's `<span>` element via `**html_attributes`,
  # and to the inner `<i>` by nested them under `icon_attributes`.
  #
  # ## Example
  #
  #     render BulmaPhlex::Icon.new("fas fa-home")
  #     render BulmaPhlex::Icon.new("fas fa-home", color: :primary, size: :large, text_right: "Home")
  class Icon < BulmaPhlex::Base
    # **Parameters**
    #
    # - `icon` — The icon class string (e.g. `"fas fa-home"`)
    # - `color` — Sets the [color of the icon](https://bulma.io/documentation/elements/icon/#colors)
    # - `size` — Sets the [size of the icon](https://bulma.io/documentation/elements/icon/#sizes)
    # - `text_right` — Text to display to the right of the icon
    # - `text_left` — Text to display to the left of the icon
    # - `left` — If `true`, adds the `is-left` class for use in form controls
    # - `right` — If `true`, adds the `is-right` class for use in form controls
    # - `**html_attributes` — Additional HTML attributes for the icon span element. Nest attributes under
    #     `icon_attributes` to apply them to the inner `<i>` element instead.
    def self.new(icon,
                 text_right: nil,
                 text_left: nil,
                 size: nil,
                 color: nil,
                 left: false,
                 right: false,
                 **html_attributes)
      super
    end

    def initialize(icon,
                   text_right: nil,
                   text_left: nil,
                   size: nil,
                   color: nil,
                   left: false,
                   right: false,
                   **html_attributes)
      @icon = icon
      @text_right = text_right
      @text_left = text_left
      @size = size
      @color = color
      @left = left
      @right = right
      @html_attributes = html_attributes.clone
      @icon_attributes = @html_attributes.delete(:icon_attributes) || {}
    end

    def view_template
      optional_text_wrapper do
        span { @text_left } if @text_left
        span(**mix({ class: icon_classes }, @html_attributes)) do
          i(class: @icon, **@icon_attributes)
        end
        span { @text_right } if @text_right
      end
    end

    private

    def optional_text_wrapper(&)
      if @text_right || @text_left
        add_aria_hidden_to_icon_attributes
        span(class: "icon-text", &)
      else
        yield
      end
    end

    def add_aria_hidden_to_icon_attributes
      @icon_attributes = mix({ aria: { hidden: "true" } }, @icon_attributes)
    end

    def icon_classes
      classes = ["icon"]
      classes << "is-#{@size}" if @size
      classes << "has-text-#{@color}" if @color
      classes << "is-left" if @left
      classes << "is-right" if @right
      classes.join(" ")
    end
  end
end
