# frozen_string_literal: true

module BulmaPhlex
  # Tabs component for toggling between different content sections
  #
  # This component implements the [Bulma tabs](https://bulma.io/documentation/components/tabs/)
  # interface, providing a way to toggle between different content sections using
  # tabbed navigation. Includes support for icons and active state management.
  #
  # Use method `right_content` to add content to the right of the tabs, such as a button.
  #
  # The tabs behavior can be managed by the data attributes provided by the `data_attributes_builder` argument. By
  # default, this will use the `StimulusDataAttributes` class with the controller name `bulma-phlex--tabs`. That
  # controlleris not provided by this library, but you can create your own Stimulus controller to handle the tab
  # switching logic. Here is an implementation of a [Stimulus controller for Bulma tabs](https://github.com/RockSolt/bulma-phlex-rails/blob/main/app/javascript/controllers/bulma_phlex/tabs_controller.js).
  #
  # ## Example
  #
  # ```ruby
  # BulmaPhlex::Tabs() do |tabs|
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
  # ## Options
  #
  # - `align`: Can be `centered` or `right` to align the tabs accordingly.
  # - `size`: Can be `small`, `medium`, or `large` to set the size of the tabs.
  # - `boxed`: If `true`, uses classic style tabs.
  # - `toggle`: If `true`, makes the tabs look like buttons.
  # - `rounded`: If `true`, makes the tabs look like buttons with the first and last rounded.
  # - `fullwidth`: If `true`, makes the tabs take up the full width of the container.
  # - `data_attributes_builder`: An object that provides methods to generate data attributes for the
  #   tabs. By default, this is an instance of `StimulusDataAttributes` with "bulma-phlex--tabs".
  #
  # Any additional HTML attributes passed to the component will be applied to the outer `<div>` element.
  class Tabs < BulmaPhlex::Base
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

    def initialize(align: nil, # rubocop:disable Metrics/ParameterLists
                   size: nil,
                   boxed: false,
                   toggle: false,
                   rounded: false,
                   fullwidth: false,
                   data_attributes_builder: StimulusDataAttributes.new("bulma-phlex--tabs"),
                   **html_attributes)
      @align = align
      @size = size
      @boxed = boxed
      @toggle = toggle || rounded
      @rounded = rounded
      @fullwidth = fullwidth
      @data_attributes_builder = data_attributes_builder
      @html_attributes = html_attributes
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

      div(**mix({ data: @data_attributes_builder.for_container }, @html_attributes)) do
        build_tabs_with_optional_right_content
        build_content
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
      attributes = {}
      attributes[:id] = "#{@html_attributes[:id]}-tabs" if @html_attributes[:id]

      div(class: tabs_classes) do
        ul(**attributes) do
          @tabs.each { render it }
        end
      end
    end

    def tabs_classes
      classes = ["tabs"]
      classes << "is-boxed" if @boxed
      classes << "is-#{@align}" if @align
      classes << "is-#{@size}" if @size
      classes << "is-toggle" if @toggle
      classes << "is-toggle-rounded" if @rounded
      classes << "is-fullwidth" if @fullwidth
      classes
    end

    def build_content
      attributes = {}
      attributes[:id] = "#{@html_attributes[:id]}-content" if @html_attributes[:id]

      div(**attributes) do
        @contents.each { render it }
      end
    end
  end
end
