# frozen_string_literal: true

module BulmaPhlex
  # # Notification
  #
  # The Bulma Notification component can be styled with the following options:
  #
  # - `delete`: If true, includes a delete button to dismiss the notification. Can also be a hash of HTML
  # attributes for the button.
  # - `color`: Sets the color of the notification. Accepts any Bulma color class suffix (e.g., "primary",
  # "info", "danger").
  # - `mode`: Sets the mode of the notification: "light" or "dark".
  #
  # Any additional HTML attributes passed to the component will be applied to the notification div.
  #
  # The content of the notification is provided via a block.
  class Notification < BulmaPhlex::Base
    def initialize(delete: false, color: nil, mode: nil, **html_attributes)
      @delete = delete
      @color = color
      @mode = mode
      @html_attributes = html_attributes
    end

    def view_template(&)
      vanish(&)

      div(**mix({ class: notification_classes }, **@html_attributes)) do
        delete_button if @delete
        yield
      end
    end

    private

    def notification_classes
      classes = ["notification"]
      classes << "is-#{@color}" if @color.present?
      classes << "is-#{@mode}" if @mode.present?
      classes.join(" ")
    end

    def delete_button
      html_attributes = { class: "delete" }
      html_attributes = mix(html_attributes, @delete) if @delete.is_a?(Hash)
      button(**html_attributes)
    end
  end
end
