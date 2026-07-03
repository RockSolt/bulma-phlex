# frozen_string_literal: true

module BulmaPhlex
  # Renders a [Bulma image](https://bulma.io/documentation/elements/image/) component.
  class Image < BulmaPhlex::Base
    # **Parameters**
    #
    # - `src:` — The image source URL (required)
    # - `alt:` — The image alt text (optional)
    # - `rounded:` — Whether to apply the `is-rounded` class (optional, default: false)
    # - `size:` — The image size (optional, e.g., 64 for `is-64x64`)
    # - `ratio:` — The image ratio (optional, e.g., "1by1", "4by3", "16by9")
    # - `img_attributes:` — Additional HTML attributes for the img element (optional)
    # - `**html_attributes` — Additional HTML attributes for the figure element (optional)
    def self.new(src:, alt: nil, rounded: false, size: nil, ratio: nil, img_attributes: {}, **html_attributes)
      super
    end

    def initialize(src:, alt: nil, rounded: false, size: nil, ratio: nil, img_attributes: {}, **html_attributes)
      @src = src
      @alt = alt
      @rounded = rounded
      @size = size
      @ratio = ratio
      @img_attributes = img_attributes
      @html_attributes = html_attributes
    end

    def view_template
      figure(**mix({ class: figure_classes }, @html_attributes)) do
        img(**mix({ src: @src, alt: @alt, class: img_classes }, @img_attributes))
      end
    end

    private

    def figure_classes
      classes = ["image"]
      classes << "is-#{@size}x#{@size}" if @size
      classes << "is-#{@ratio}" if @ratio
      classes.join(" ")
    end

    def img_classes
      "is-rounded" if @rounded
    end
  end
end
