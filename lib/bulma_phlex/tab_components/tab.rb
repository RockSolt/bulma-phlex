# frozen_string_literal: true

module BulmaPhlex
  module TabComponents
    # Renders a single tab item within a {BulmaPhlex::Tabs} component.
    #
    # Can also be used standalone when you need to create or update a tab dynamically.
    class Tab < BulmaPhlex::Base
      # **Parameters**
      # - `id` — Unique identifier for the tab
      # - `title` — The text displayed on the tab
      # - `icon` — Optional icon class to display on the tab (e.g. `"fas fa-cog"`)
      # - `active` — If `true`, marks the tab as currently active
      # - `data_attributes_proc` — A proc that generates data attributes for the tab
      def self.new(id:, title:, icon:, active:,
                   data_attributes_proc: BulmaPhlex::Tabs::StimulusDataAttributes.new("bulma-phlex--tabs").method(:for_tab))
        super
      end

      def initialize(id:, title:, icon:, active:,
                     data_attributes_proc: BulmaPhlex::Tabs::StimulusDataAttributes.new("bulma-phlex--tabs").method(:for_tab))
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
            Icon(@icon, class: "mr-1") if @icon
            span { @title }
          end
        end
      end
    end
  end
end
