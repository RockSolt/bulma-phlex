# frozen_string_literal: true

module BulmaPhlex
  # # Button
  #
  # This component implements the [Bulma button](https://bulma.io/documentation/elements/button/)
  # interface. It provides a simple way to create buttons with the appropriate Bulma classes.
  #
  # ## Options
  #
  # - `color`: Sets the button color (e.g., "primary", "link", "info", "success", "warning", "danger").
  # - `mode`: Sets the mode of the notification: "light" or "dark".
  # - `size`: Sets the button size: "small", "normal" (the default), "medium", or "large".
  # - `responsive`: If `true`, makes the button responsive.
  # - `fullwidth`: If `true`, makes the button full width.
  # - `outlined`: If `true`, makes the button outlined.
  # - `inverted`: If `true`, makes the button inverted.
  # - `rounded`: If `true`, makes the button rounded.
  # - `icon`: If provided, adds an icon to the button. Should be a string representing
  #   the icon class (e.g., "fa-solid fa-check").
  # - `icon_left`: If provided, adds an icon to the left of the button text. Should be a string
  #   representing the icon class (e.g., "fa-solid fa-check").
  # - `icon_right`: If provided, adds an icon to the right of the button text. Should be a string
  #   representing the icon class (e.g., "fa-solid fa-check").
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

    def initialize(color: nil,
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
                   **html_attributes)
      @classes = self.class.classes_for(color:, mode:, size:, responsive:, fullwidth:, outlined:, inverted:, rounded:)
      @icon_left = icon || icon_left
      @icon_right = icon_right
      @html_attributes = html_attributes
    end

    def view_template(&)
      button(**mix({ class: @classes }, @html_attributes)) do
        Icon(@icon_left) if @icon_left
        yield if block_given?
        Icon(@icon_right) if @icon_right
      end
    end
  end
end
