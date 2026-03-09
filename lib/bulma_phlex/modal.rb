# frozen_string_literal: true

module BulmaPhlex
  # Renders a [Bulma modal](https://bulma.io/documentation/components/modal/) dialog overlay.
  #
  # Consists of a background, content area, and a close button. Content is provided via a block.
  # Supports customization of the **Stimulus controller** used for open/close behavior via the
  # `data_attributes_builder` option.
  class Modal < BulmaPhlex::Base
    StimulusDataAttributes = Data.define(:stimulus_controller) do
      def for_container = { controller: stimulus_controller }
      def for_background = { action: "click->bulma-phlex--modal#close" }
      def for_close_button = { action: "bulma-phlex--modal#close" }
    end

    # **Parameters**
    #
    # - `data_attributes_builder` — Provides data attributes for the container, background, and close button.
    #   Defaults to a `StimulusDataAttributes` instance with the controller name `"bulma-phlex--modal"`.
    #   Provide a custom builder to use a different controller or customize the data attributes.
    # - `**html_attributes` — Additional HTML attributes for the outer `<div>` element
    def self.new(data_attributes_builder: StimulusDataAttributes.new("bulma-phlex--modal"), **html_attributes)
      super
    end

    def initialize(data_attributes_builder: StimulusDataAttributes.new("bulma-phlex--modal"), **html_attributes)
      @data_attributes_builder = data_attributes_builder
      @html_attributes = html_attributes
    end

    def view_template(&)
      container = { class: "modal", data: @data_attributes_builder.for_container }
      div(**mix(container, @html_attributes)) do
        div(class: "modal-background", data: @data_attributes_builder.for_background)
        div(class: "modal-content", &)
        button(class: "modal-close is-large", aria: { label: "close" }, data: @data_attributes_builder.for_close_button)
      end
    end
  end
end
