# frozen_string_literal: true

module BulmaPhlex
  # Renders the [Bulma level](https://bulma.io/documentation/layout/level/) component.
  #
  # A flexible horizontal layout system. Items can be placed in the **left** section, the
  # **right** section, or centered as standalone **items**. Content in each section is
  # provided via `left`, `right`, and `item` block methods on the yielded component.
  #
  # ## Example:
  #
  #     render BulmaPhlex::Level.new do |level|
  #       level.left do
  #         button(class: "button") { "Left" }
  #       end
  #
  #       level.right do
  #         button(class: "button") { "Right" }
  #       end
  #       level.right do
  #         button(class: "button") { "Right 2" }
  #       end
  #     end
  class Level < BulmaPhlex::Base
    # **Parameters**
    # - `**html_attributes` — Additional HTML attributes for the level element
    def self.new(**html_attributes)
      super
    end

    def initialize(**html_attributes)
      @html_attributes = html_attributes
      @items = []
      @left = []
      @right = []
    end

    def view_template(&)
      vanish(&)

      div(**mix({ class: "level" }, @html_attributes)) do
        div(class: "level-left") do
          @left.each { |item| level_item(item) }
        end

        @items.each { |item| level_item(item) }

        div(class: "level-right") do
          @right.each { |item| level_item(item) }
        end
      end
    end

    def item(&content)
      @items << content
    end

    def left(&content)
      @left << content
    end

    def right(&content)
      @right << content
    end

    private

    def level_item(content)
      div(class: "level-item") { content.call }
    end
  end
end
