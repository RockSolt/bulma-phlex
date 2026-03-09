# frozen_string_literal: true

module BulmaPhlex
  module TabComponents
    # Renders a single content panel within a {BulmaPhlex::Tabs} component.
    #
    # ## Arguments:
    # - `id`: Unique identifier for the content.
    # - `active`: Boolean indicating if the content is currently active.
    # - `data_attributes_proc`: A proc that generates data attributes for the content.
    class Content < BulmaPhlex::Base
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
