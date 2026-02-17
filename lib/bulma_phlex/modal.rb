# frozen_string_literal: true

module BulmaPhlex
  # ## Modal
  #
  # The Bulma Modal component is used to create modal dialogs. It consists of a background,
  # content area, and a close button. The content of the modal can be defined using the block
  # passed to the `call` method.
  #
  # The constructor accepts an optional `data_attributes_builder` argument, which allows you to
  # provide data attributes for the container, background, and close button. By default, it uses a
  # `StimulusDataAttributes` instance with the controller name "bulma-phlex--modal". You can provide your
  # own builder if you want to use a different controller or customize the data attributes further.
  #
  # Any additional HTML attributes passed to the constructor will be applied to the outer `<div>`
  # element of the modal.
  class Modal < BulmaPhlex::Base
    StimulusDataAttributes = Data.define(:stimulus_controller) do
      def for_container = { controller: stimulus_controller }
      def for_background = { action: "click->bulma-phlex--modal#close" }
      def for_close_button = { action: "bulma-phlex--modal#close" }
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
