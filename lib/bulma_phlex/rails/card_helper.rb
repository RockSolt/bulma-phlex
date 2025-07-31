# frozen_string_literal: true

module BulmaPhlex
  module Rails
    # # Card Helper
    #
    # This module provides method `turbo_frame_content` to create a card with a turbo frame as its content.
    module CardHelper
      extend ActiveSupport::Concern

      included do
        include Phlex::Rails::Helpers::TurboFrameTag
      end

      # Renders a Bulma-styled card with a Turbo Frame as its content. This uses the same signatures as
      # `turbo_frame_tag`, with the addition of two optional attributes: `pending_message` and `pending_icon`.
      #
      # The two pending attributes have the following defaults:
      # - pending_message: "Loading..."
      # - pending_icon: "fas fa-spinner fa-pulse"
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
