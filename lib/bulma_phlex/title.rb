# frozen_string_literal: true

module BulmaPhlex
  # Renders a [Bulma title element](https://bulma.io/documentation/elements/title/) with an optional subtitle.
  #
  # Supports **size** (1–6) for both the title and subtitle, an optional **subtitle** string, and
  # a **spaced** layout option to increase the gap between the title and subtitle.
  #
  # ## Example
  #
  #     render BulmaPhlex::Title.new("Hello World")
  #     render BulmaPhlex::Title.new("Dr. Strangelove", size: 2, subtitle: "Or: How I Learned to Stop Worrying and
  #       Love the Bomb")
  class Title < BulmaPhlex::Base
    # **Parameters**
    # - `text` — The main title text to display
    # - `size` — An integer from 1 to 6 indicating the title size; corresponds to Bulma's `is-<size>` classes
    # - `subtitle` — The subtitle text to display below the main title
    # - `subtitle_size` — An integer from 1 to 6 indicating the subtitle size; defaults to `size + 2` if `size` is set
    # - `spaced` — If `true`, adds the `is-spaced` class to the title
    def self.new(text, size: nil, subtitle: nil, subtitle_size: nil, spaced: false)
      super
    end

    def initialize(text, size: nil, subtitle: nil, subtitle_size: nil, spaced: false)
      @text = text
      @size = size
      @subtitle = subtitle
      @subtitle_size = subtitle_size
      @spaced = spaced
    end

    def view_template
      h1(class: title_classes) { @text }
      h2(class: subtitle_classes) { @subtitle } if @subtitle
    end

    private

    def title_classes
      classes = ["title"]
      classes << "is-#{@size}" if @size
      classes << "is-spaced" if @spaced
      classes.join(" ")
    end

    def subtitle_classes
      @subtitle_size = @size + 2 if @size && !@subtitle_size
      classes = ["subtitle"]
      classes << "is-#{@subtitle_size}" if @subtitle_size
      classes.join(" ")
    end
  end
end
