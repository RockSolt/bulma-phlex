# frozen_string_literal: true

module BulmaPhlex
  # # Form Control
  #
  # The Bulma Form Control is used to wrap form elements like inputs, selects, and textareas. Additional classes can
  # be added via the `classes` argument.
  #
  # ## References
  # - [Bulma Form Control](https://bulma.io/documentation/form/general/#form-control)
  class FormControl < Phlex::HTML
    def initialize(**attributes)
      @attributes = attributes.compact
    end

    def view_template(&)
      div(**mix({ class: "control" }, @attributes), &)
    end
  end
end
