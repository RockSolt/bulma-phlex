# frozen_string_literal: true

module BulmaPhlex
  # Renders a [Bulma media object](https://bulma.io/documentation/components/media-object/) component.
  #
  # Optional HTML attributes can be passed to the constructor as well as any of the three block methods,
  # `left`, `content`, and `right`, to customize the rendered HTML elements.
  #
  # ## Example
  #
  #     render BulmaPhlex::MediaObject.new do |media|
  #       media.left do
  #         p(class: "image is-64x64") do
  #           img(src: "/assets/images/placeholders/128x128.png")
  #         end
  #       end
  #
  #       media.content do
  #         p { "This is the main content of the media object." }
  #       end
  #
  #       media.right do
  #         button(class: "delete")
  #       end
  #     end
  class MediaObject < BulmaPhlex::Base
    # **Parameters**
    #
    # - `**html_attributes` — Additional HTML attributes for the wrapping `article` element
    def self.new(**html_attributes)
      super
    end

    def initialize(**html_attributes)
      @html_attributes = html_attributes
    end

    def view_template(&)
      vanish(&)

      article(**mix({ class: "media" }, @html_attributes)) do
        render_media_left if @media_left
        render_media_content if @media_content
        render_media_right if @media_right
      end
    end

    # Use a block to provide the left content, which will be wrapped in a `figure` element. Additional
    # HTML attributes can be passed to customize the element.
    #
    #   <figure class="media-left">
    #     <!-- Left content goes here -->
    #   </figure>
    def left(**html_attributes, &block)
      @left_attributes = html_attributes
      @media_left = block
    end

    # If the left content is an image, you can use this method to provide the image source,
    # alt text, size, and whether it should be rounded. Additional HTML attributes can be
    # passed to customize the `figure` element.
    def image(src:, alt: nil, size: nil, rounded: false, **html_attributes)
      left(**html_attributes) do
        p(class: image_classes(size:)) do
          img(src:, alt:, class: ("is-rounded" if rounded))
        end
      end
    end

    # Use a block to provide the main content, which will be wrapped in a `div` element. Additional
    # HTML attributes can be passed to customize the element.
    #
    #   <div class="media-content">
    #    <!-- Main content goes here -->
    #  </div>
    def content(**html_attributes, &block)
      @content_attributes = html_attributes
      @media_content = block
    end

    # Use a block to provide the right content, which will be wrapped in a `div` element. Additional
    # HTML attributes can be passed to customize the element.
    #
    #   <div class="media-right">
    #     <!-- Right content goes here -->
    #   </div>
    def right(**html_attributes, &block)
      @right_attributes = html_attributes
      @media_right = block
    end

    private

    def render_media_left
      figure(**mix({ class: "media-left" }, @left_attributes)) do
        @media_left.call
      end
    end

    def render_media_content
      div(**mix({ class: "media-content" }, @content_attributes)) do
        @media_content.call
      end
    end

    def render_media_right
      div(**mix({ class: "media-right" }, @right_attributes)) do
        @media_right.call
      end
    end

    def image_classes(size:)
      classes = ["image"]
      classes << "is-#{size}x#{size}" if size
      classes.join(" ")
    end
  end
end
