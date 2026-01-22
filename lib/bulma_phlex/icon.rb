# frozen_string_literal: true

module BulmaPhlex
  # # Icon
  #
  # This component implements the
  # [Bulma icon element](https://bulma.io/documentation/elements/icon/).
  #
  # ## Options
  #
  # - `color`: Sets the [color of the icon](https://bulma.io/documentation/elements/icon/#colors)
  # - `size`: Sets the [size of the icon](https://bulma.io/documentation/elements/icon/#sizes)
  # - `text_right`: Text to display to the right of the icon
  # - `text_left`: Text to display to the left of the icon
  # - `left`: If true, adds the `is-left` class for use in form controls
  # - `right`: If true, adds the `is-right` class for use in form controls
  #
  # ## Example
  #
  # ```ruby
  # BulmaPhlex::Icon.new("fas fa-home")
  # BulmaPhlex::Icon.new("fas fa-home", color: :primary, size: :large, text_right: "Home")
  # ```
  class Icon < BulmaPhlex::Base
    def initialize(icon, # rubocop:disable Metrics/ParameterLists
                   text_right: nil,
                   text_left: nil,
                   size: nil,
                   color: nil,
                   left: false,
                   right: false)
      @icon = icon
      @text_right = text_right
      @text_left = text_left
      @size = size
      @color = color
      @left = left
      @right = right
    end

    def view_template
      optional_text_wrapper do
        span { @text_left } if @text_left
        span(class: icon_classes) do
          i(class: @icon)
        end
        span { @text_right } if @text_right
      end
    end

    private

    def optional_text_wrapper(&)
      if @text_right || @text_left
        span(class: "icon-text", &)
      else
        yield
      end
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
