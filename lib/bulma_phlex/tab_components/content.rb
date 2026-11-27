# frozen_string_literal: true

module BulmaPhlex
  module TabComponents
    # Renders a single content panel within a {BulmaPhlex::Tabs} component.
    #
    # Manages visibility (shown/hidden) based on the **active** state, and accepts a
    # **data attributes proc** for Stimulus integration.
    #
    class Content < BulmaPhlex::Base
      # **Parameters**
      #
      # - `id` — Unique identifier for the content panel
      # - `active` — If `true`, the content panel is visible; otherwise it is hidden
      # - `data_attributes_proc` — A proc that generates data attributes for the content panel
      def self.new(id:, active:, data_attributes_proc: nil)
        super
      end

      def initialize(id:, active:, data_attributes_proc: nil)
        @id = id
        @active = active
        @data_attributes = data_attributes_proc ||
                           BulmaPhlex::Tabs::StimulusDataAttributes.new("bulma-phlex--tabs").method(:for_content)
      end

      def view_template(&)
        div(id: @id,
            class: @active ? "" : "is-hidden",
            data: @data_attributes.call(@id), &)
      end

      # This method is new in Phlex 3.0 and is used to handle a block, which is no longer valid at initialization
      # When this library requires Phlex 3.0, this method can be removed
      #
      # https://github.com/yippee-fun/phlex/pull/1104
      unless method_defined?(:with_content)
        def with_content(&block)
          raise(Phlex::ArgumentError, "with_content requires a block.") unless block

          @_content_block = block
          self
        end
      end
    end
  end
end
