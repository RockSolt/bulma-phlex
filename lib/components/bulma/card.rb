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

      if defined?(Phlex::Rails)
        include Phlex::Rails::Helpers::TurboFrameTag

        # this copies the signature of the turbo_frame_tag helper,
        # with the addition of a pending_message attribute
        def turbo_frame_content(*ids, src: nil, target: nil, **attributes)
          pending_message = attributes.delete(:pending_message) || "Loading..."
          pending_icon = attributes.delete(:pending_icon) || "fas fa-spinner fa-pulse"

          content do
            turbo_frame_tag ids, src: src, target: target, **attributes do
              span(class: "icon") { i class: pending_icon }
              span { plain pending_message }
            end
          end
        end
      end
    end
  end
end
