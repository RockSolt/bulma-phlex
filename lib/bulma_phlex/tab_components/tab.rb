# frozen_string_literal: true

module BulmaPhlex
  module TabComponents
    # # Tab
    #
    # This component represents a single tab within the Bulma Tabs component.
    #
    # The component can be used if you need to create or update a tab dynamically.
    #
    # ## Arguments
    #
    # - `id`: Unique identifier for the tab.
    # - `title`: The text displayed on the tab.
    # - `icon`: Optional icon to display on the tab.
    # - `active`: Boolean indicating if the tab is currently active.
    # - `data_attributes_proc`: A proc that generates data attributes for the tab.
    class Tab < BulmaPhlex::Base
      def initialize(id:, title:, icon:, active:,
                     data_attributes_proc: BulmaPhlex::Tabs::StimulusDataAttributes.new("bulma--tabs").method(:for_tab))
        @id = id
        @title = title
        @icon = icon
        @active = active
        @data_attributes_proc = data_attributes_proc
      end

      def view_template(&)
        li(
          id: "#{@id}-tab",
          data: @data_attributes_proc.call(@id),
          class: @active ? "is-active" : ""
        ) do
          a do
            icon_span(@icon, "mr-1") if @icon
            span { @title }
          end
        end
      end
    end
  end
end
