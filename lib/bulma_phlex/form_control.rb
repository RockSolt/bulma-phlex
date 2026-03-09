# frozen_string_literal: true

module BulmaPhlex
  # Wraps form elements in a [Bulma form control](https://bulma.io/documentation/form/general/#form-control)
  # container with optional left/right icons.
  #
  # ## References
  # - [Bulma Form Control](https://bulma.io/documentation/form/general/#form-control)
  class FormControl < Base
    # **Parameters**
    # - `icon_left` — Icon class for the left side of the control (e.g. `"fas fa-check"`)
    # - `icon_right` — Icon class for the right side of the control (e.g. `"fas fa-check"`)
    # - `**html_attributes` — Additional HTML attributes for the control element
    def self.new(icon_left: nil, icon_right: nil, **html_attributes)
      super
    end

    def initialize(icon_left: nil, icon_right: nil, **html_attributes)
      @icon_left = icon_left
      @icon_right = icon_right
      @html_attributes = html_attributes
    end

    def view_template(&)
      div(**mix({ class: classes }, @html_attributes)) do
        raw yield
        Icon(@icon_left, size: :small, left: true) if @icon_left
        Icon(@icon_right, size: :small, right: true) if @icon_right
      end
    end

    private

    def classes
      ["control"].tap do |classes|
        classes << "has-icons-left" if @icon_left
        classes << "has-icons-right" if @icon_right
      end
    end
  end
end
