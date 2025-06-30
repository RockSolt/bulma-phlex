# frozen_string_literal: true

module Components
  module Bulma
    module TabComponents
      # # Content
      #
      # This component represents a single content section within the Bulma Tabs component.
      #
      # ## Arguments:
      # - `id`: Unique identifier for the content.
      # - `active`: Boolean indicating if the content is currently active.
      # - `data_attributes`: A hash of data attributes to be applied to the content element.
      class Content < Components::Bulma::Base
        def initialize(id:, active:, data_attributes: nil)
          @id = id
          @active = active
          @data_attributes = data_attributes || Components::Bulma::Tabs::StimulusDataAttributes.new("bulma--tabs").for_content
        end

        def view_template(&)
          div(id: @id,
              class: @active ? "" : "is-hidden",
              data: @data_attributes, &)
        end
      end
    end
  end
end
