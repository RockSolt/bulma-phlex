# frozen_string_literal: true

module BulmaPhlex
  # Renders the [Bulma progress bar element](https://bulma.io/documentation/elements/progress/).
  #
  # Supports **color** and **size** options. Omitting `value` and `max` from the HTML attributes
  # produces an indeterminate (animated) progress bar.
  class ProgressBar < Base
    # **Parameters**
    # - `color` — [Color of the progress bar](https://bulma.io/documentation/elements/progress/#colors)
    # - `size` — [Size of the progress bar](https://bulma.io/documentation/elements/progress/#sizes): `"small"`,
    # `"normal"`, `"medium"`, `"large"`
    # - `**html_attributes` — Additional HTML attributes for the progress element; use `value` and `max` to set progress
    def self.new(color: nil, size: nil, **html_attributes)
      super
    end

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
