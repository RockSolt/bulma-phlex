# frozen_string_literal: true

module BulmaPhlex
  # Level component for responsive horizontal layouts
  #
  # This component implements the [Bulma level](https://bulma.io/documentation/layout/level/)
  # interface, providing a flexible horizontal layout system with left and right alignment.
  #
  # ## Example:
  #
  # ```ruby
  # Bulma::Level() do |level|
  #   level.left do
  #     button(class: "button") { "Left" }
  #   end
  #
  #   level.right do
  #     button(class: "button") { "Right" }
  #   end
  #   level.right do
  #     button(class: "button") { "Right 2" }
  #   end
  # end
  # ```
  #
  class Level < Components::Bulma::Base
    def initialize
      @items = []
      @left = []
      @right = []
    end

    def view_template(&)
      vanish(&)

      div(class: "level") do
        div(class: "level-left") do
          @left.each { level_item(it) }
        end

        @items.each { level_item(it) }

        div(class: "level-right") do
          @right.each { level_item(it) }
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
