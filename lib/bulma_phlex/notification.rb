# frozen_string_literal: true

module BulmaPhlex
  # Renders a [Bulma notification](https://bulma.io/documentation/elements/notification/) component.
  #
  # A styled alert box for displaying messages to the user. Supports **color** and **style mode**
  # (light/dark) options, and optionally includes a **dismiss button** whose HTML attributes
  # can be customized. Content is provided via a block.
  class Notification < BulmaPhlex::Base
    # **Parameters**
    # - `delete` — If `true`, includes a delete button to dismiss the notification. Can also be a hash of HTML
    #  attributes for the button
    # - `color` — Color of the notification (e.g. `"primary"`, `"info"`, `"danger"`)
    # - `mode` — Style mode: `"light"` or `"dark"`
    # - `**html_attributes` — Additional HTML attributes for the notification element
    def self.new(delete: false, color: nil, mode: nil, **html_attributes)
      super
    end

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
