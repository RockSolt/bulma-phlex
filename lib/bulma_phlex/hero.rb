# frozen_string_literal: true

module BulmaPhlex
  # Renders a [Bulma Hero](https://bulma.io/documentation/layout/hero/) component.
  #
  # Supports **color** and **size** options. Content can be provided as a title/subtitle pair,
  # a single block for the body, or by calling `head`, `body`, and `foot` on the yielded
  # component to define each section independently.
  class Hero < BulmaPhlex::Base
    # **Parameters**
    # - `title` — Main title text for the hero body
    # - `subtitle` — Subtitle text displayed below the title
    # - `color` — Hero color (e.g. `"primary"`, `"info"`, `"success"`, `"warning"`, `"danger"`)
    # - `size` — Hero size: `"small"`, `"medium"`, `"large"`, `"halfheight"`, `"fullheight"`
    # - `**html_attributes` — Additional HTML attributes for the hero `<section>` element
    def self.new(title: nil, subtitle: nil, color: nil, size: nil, **html_attributes)
      super
    end

    def initialize(title: nil, subtitle: nil, color: nil, size: nil, **html_attributes)
      @title = title
      @subtitle = subtitle
      @color = color
      @size = size
      @html_attributes = html_attributes
    end

    def head(&block)
      @head = block
    end

    def body(&block)
      @body = block
    end

    def foot(&block)
      @foot = block
    end

    def view_template(&)
      output = capture(&)

      section(**mix({ class: hero_classes }, @html_attributes)) do
        if @body.present?
          building_blocks(&)
        else
          div(class: "hero-body") do
            if output.present?
              output
            else
              title_and_subtitle
            end
          end
        end
      end
    end

    private

    def hero_classes
      classes = ["hero"]
      classes << "is-#{@color}" if @color
      classes << "is-#{@size}" if @size
      classes
    end

    def building_blocks(&)
      div(class: "hero-head") { @head.call } if @head
      div(class: "hero-body") { @body.call } if @body
      div(class: "hero-foot") { @foot.call } if @foot
    end

    def title_and_subtitle
      p(class: "title") { @title } if @title
      p(class: "subtitle") { @subtitle } if @subtitle
    end
  end
end
