# frozen_string_literal: true

module BulmaPhlex
  # Renders a [Bulma message](https://bulma.io/documentation/components/message/) component with a
  # header, optional delete button, and body.
  #
  # The component generates an `article` element and supports color and size options, as well as any
  # additional html attributes.
  class Message < BulmaPhlex::Base
    # **Parameters**
    #
    # - `header_text` (positional, optional) — If not provided, the header will be skipped
    # - `delete` — If `true`, includes a delete button to dismiss the message. Can also be a hash of HTML
    #  attributes for the button
    # - `color` — Color of the notification (e.g. `"primary"`, `"info"`, `"danger"`)
    # - `size` — `"small"`, `"normal"` (the default), `"medium"` or `"large"`
    # - `**html_attributes` — Additional HTML attributes for the notification element
    def self.new(header_text = nil, delete: nil, color: nil, size: nil, **html_attributes)
      super
    end

    def initialize(header_text = nil, delete: nil, color: nil, size: nil, **html_attributes)
      @header_text = header_text
      @delete = delete
      @color = color
      @size = size
      @html_attributes = html_attributes
      after_initialize
    end

    def view_template(&)
      vanish(&)

      article(**mix({ class: message_classes }, **@html_attributes)) do
        message_header if @header_text.present?
        message_body(&)
      end
    end

    private

    # allows for easy customization
    def after_initialize; end

    def message_classes
      classes = ["message"]
      classes << "is-#{@color}" if @color.present?
      classes << "is-#{@size}" if @size.present? && @size.to_s != "normal"
      classes.join(" ")
    end

    def message_header
      div(class: "message-header") do
        p { @header_text }
        delete_button if @delete
      end
    end

    def delete_button
      button_attributes = { class: "delete", aria_label: "delete" }
      button_attributes = mix(button_attributes, @delete) if @delete.is_a?(Hash)
      button(**button_attributes)
    end

    def message_body(&)
      div(class: "message-body", &)
    end
  end
end
