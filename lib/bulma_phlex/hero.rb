# frozen_string_literal: true

module BulmaPhlex
  # ## Hero
  #
  # This component implements the [Bulma Hero](https://bulma.io/documentation/layout/hero/) layout. There are
  # three ways to invoke the component:
  #
  # - with a title and subtitle argument
  # - with a block for the hero body content
  # - invoke methods head, body, and footer on the yielded component and pass blocks to define each section
  #
  # Additionally, both the size and color of the Hero can be specified through keyword arguments in the
  # constructor. Any additional HTML attributes given to the constructor will be added to the containing `div`.
  class Hero < BulmaPhlex::Base
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
