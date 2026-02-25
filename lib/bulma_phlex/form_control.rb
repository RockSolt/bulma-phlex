# frozen_string_literal: true

module BulmaPhlex
  # # Form Control
  #
  # The Bulma Form Control is used to wrap form elements like inputs, selects, and buttons. It can optionally
  # include icons on the left and/or right side of the control.
  #
  # ## Options
  #
  # - `icon_left`: If provided, adds an icon to the left of the control. Should be a string representing
  #   the icon class (e.g., "fas fa-check").
  # - `icon_right`: If provided, adds an icon to the right of the control. Should be a string representing
  #   the icon class (e.g., "fas fa-check").
  #
  # ## References
  # - [Bulma Form Control](https://bulma.io/documentation/form/general/#form-control)
  class FormControl < Phlex::HTML
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
