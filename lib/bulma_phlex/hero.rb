# frozen_string_literal: true

module BulmaPhlex
  # Renders a [Bulma Hero](https://bulma.io/documentation/layout/hero/) component.
  #
  # Supports **color** and **size** options. There are three ways to provide content:
  #
  # 1. **Title/subtitle params** — pass `title:` and/or `subtitle:` to the constructor; no block needed.
  # 2. **Direct body block** — pass a block to `render`; call Phlex HTML methods on the yielded
  #    component and they are rendered inside the `hero-body` div.
  # 3. **Building blocks** — call `head`, `body`, and `foot` on the yielded component to
  #    populate each of Bulma's three hero regions independently:
  #    - `hero-head` — typically a navbar or branding bar
  #    - `hero-body` — main content area
  #    - `hero-foot` — bottom tabs or action bar
  class Hero < BulmaPhlex::Base
    # **Parameters**
    #
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
        if @body.nil?
          div(class: "hero-body") do
            if output.empty?
              title_and_subtitle
            else
              raw safe(output)
            end
          end
        else
          building_blocks(&)
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
