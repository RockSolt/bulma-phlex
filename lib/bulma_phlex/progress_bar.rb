# frozen_string_literal: true

module BulmaPhlex
  # Progress Bar
  #
  # This component implements the [Bulma progress bar element](https://bulma.io/documentation/elements/progress/).
  #
  # ## Options
  #
  # - `color`: Sets the [color of the progress bar](https://bulma.io/documentation/elements/progress/#colors)
  # - `size`: Sets the [size of the progress bar](https://bulma.io/documentation/elements/progress/#sizes): small,
  #    normal, medium, or large.
  # - `html_attributes`: Additional HTML attributes to add to the progress element. It is expected that the
  #    `value` and `max` attributes will be included here to set the progress bar's value and maximum value.
  #
  # Leaving out the `value` and `max` attributes will result in an indeterminate progress bar, which is useful for
  # indicating that a process is ongoing without specifying how much of it is complete.
  class ProgressBar < Base
    def initialize(color: nil, size: nil, **html_attributes)
      @color = color
      @size = size
      @html_attributes = html_attributes
    end

    def view_template(&)
      progress(**mix({ class: classes }, @html_attributes), &)
    end

    private

    def classes
      classes = ["progress"]
      classes << "is-#{@color}" if @color
      classes << "is-#{@size}" if @size
      classes
    end
  end
end
