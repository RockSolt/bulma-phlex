# frozen_string_literal: true

module Components
  module Bulma
    # Card component for content display
    #
    # This component implements the [Bulma card](https://bulma.io/documentation/components/card/)
    # interface. Cards are flexible containers that can display various types of content
    # including headers, content sections, and more.
    #
    # ## Example
    #
    # ```ruby
    # Bulma::Card() do |card|
    #   card.head("Card Title")
    #   card.content do
    #     "This is some card content"
    #   end
    # end
    # ```
    #
    # ## Rails Feature: Turbo Frame Content
    #
    # If the project includes Rails and the Phlex::Rails gem, the `BulmaPhlex::Rails::CardHelper` module
    # provides a `turbo_frame_content` method to create a card with a turbo frame
    # as its content. This allows for dynamic loading of card content.
    class Card < Components::Bulma::Base
      def view_template(&)
        div(class: "card", &)
      end

      def head(title, classes: nil)
        header(class: "card-header #{classes}") do
          p(class: "card-header-title") { plain title }
        end
      end

      def content(&)
        div(class: "card-content") do
          div(class: "content", &)
        end
      end
    end
  end
end
