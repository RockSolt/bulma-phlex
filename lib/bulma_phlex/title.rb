# frozen_string_literal: true

module BulmaPhlex
  # # Title
  #
  # This component implements the
  # [Bulma title element](https://bulma.io/documentation/elements/title/). It can optionally
  # include a subtitle as well.
  #
  # ## Parameters
  #
  # - `text`: (positional, required) The main title text to display.
  # - `size`: (optional) An integer from 1 to 6 indicating the size of the title. Corresponds to
  #     Bulma's `is-<size>` classes.
  # - `subtitle`: (optional) The subtitle text to display below the main title.
  # - `subtitle_size`: (optional) An integer from 1 to 6 indicating the size of the subtitle. If
  #     not provided and a title size is given, it defaults to `size + 2`.
  # - `spaced`: (optional) A boolean indicating whether to add the `is-spaced` class to the title.
  #
  # ## Example
  #
  # ```ruby
  # BulmaPhex::Title("Hello World")
  # BulmaPhex::Title("Dr. Strangelove", size: 2, subtitle: "Or: How I Learned to Stop Worrying and
  #   Love the Bomb")
  # ```
  class Title < BulmaPhlex::Base
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
