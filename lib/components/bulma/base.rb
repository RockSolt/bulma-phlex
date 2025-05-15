# frozen_string_literal: true

module Components
  module Bulma
    # Base component for all Bulma components
    #
    # This is the parent class for all Bulma components in this library.
    # It provides common utility methods and inherits from `Phlex::HTML`.
    #
    class Base < Phlex::HTML

      private

      def icon_span(icon, additional_classes = nil)
        span(class: "icon #{additional_classes}".strip) do
          i(class: icon)
        end
      end
    end
  end
end
