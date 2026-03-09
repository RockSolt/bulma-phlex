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
    end
  end
end
