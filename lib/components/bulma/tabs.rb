# frozen_string_literal: true

module Components
  module Bulma
    # Tabs component for toggling between different content sections
    #
    # This component implements the [Bulma tabs](https://bulma.io/documentation/components/tabs/)
    # interface, providing a way to toggle between different content sections using
    # tabbed navigation. Includes support for icons and active state management.
    #
    # Classes can be assigned to either the tabs or contents wrappers. The tabs div is where Bulma
    # options such as `is-boxed`, `is-centered`, or `is-small` can be added.
    #
    # Use method `right_content` to add content to the right of the tabs, such as a button.
    #
    # The tabs behavior can be managed by the data attributes provided by the `data_attributes_builder` argument. By
    # default, this will use the `StimulusDataAttributes` class with the controller name `bulma--tabs`. That controller
    # is not provided by this library, but you can create your own Stimulus controller to handle the tab switching
    # logic. Here is [an implementation of a Stimulus controller for Bulma tabs](https://github.com/RockSolt/bulma-rails-helpers/blob/main/app/javascript/controllers/bulma/tabs_controller.js).
    #
    # ## Example
    #
    # ```ruby
    # render Components::Bulma::Tabs.new do |tabs|
    #   tabs.tab(id: "profile", title: "Profile", active: true) do
    #     "Profile content goes here"
    #   end
    #
    #   tabs.tab(id: "settings", title: "Settings", icon: "fas fa-cog") do
    #     "Settings content goes here"
    #   end
    #
    #   tabs.tab(id: "notifications", title: "Notifications", icon: "fas fa-bell") do
    #     "Notifications content goes here"
    #   end
    # end
    # ```
    #
    class Tabs < Components::Bulma::Base
      StimulusDataAttributes = Data.define(:stimulus_controller) do
        def for_container
          { controller: stimulus_controller }
        end

        def for_tab(id)
          {
            target_key => "tab",
            tab_content: id,
            action: "click->#{stimulus_controller}#showTabContent"
          }
        end

        def for_content(_id)
          { target_key => "content" }
        end

        private

        def target_key
          "#{stimulus_controller}-target"
        end
      end

      def initialize(id: nil, tabs_class: nil, contents_class: nil,
                     data_attributes_builder: StimulusDataAttributes.new("bulma--tabs"))
        @id = id || "tabs"
        @tabs_class = tabs_class
        @contents_class = contents_class
        @data_attributes_builder = data_attributes_builder
        @tabs = []
        @contents = []
      end

      def tab(id:, title:, icon: nil, active: false, &)
        @tabs << TabComponents::Tab.new(id:, title:, icon:, active:,
                                        data_attributes_proc: @data_attributes_builder.method(:for_tab))
        @contents << TabComponents::Content.new(id:, active:,
                                                data_attributes_proc: @data_attributes_builder.method(:for_content),
                                                &)
      end

      def right_content(&content)
        @right_content = content
      end

      def view_template(&)
        vanish(&)

        div(id: @id, data: @data_attributes_builder.for_container) do
          build_tabs_with_optional_right_content
          div(id: "#{@id}-content", class: @contents_class) { build_content }
        end
      end

      private

      def build_tabs_with_optional_right_content
        return build_tabs if @right_content.nil?

        div(class: "columns") do
          div(class: "column") { build_tabs }
          div(class: "column is-narrow") { @right_content.call }
        end
      end

      def build_tabs
        div(class: "tabs #{@tabs_class}".strip) do
          ul(id: "#{@id}-tabs") do
            @tabs.each { render it }
          end
        end
      end

      def build_content
        @contents.each { render it }
      end
    end
  end
end
