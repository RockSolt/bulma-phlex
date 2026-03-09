# frozen_string_literal: true

module BulmaPhlex
  # Renders a [Bulma tabs](https://bulma.io/documentation/components/tabs/) component.
  #
  # Supports Bulma options for **alignment**, **size**, and **style** (boxed, toggle, rounded, fullwidth).
  # Each tab can include an optional **icon** and an **active** state. An optional **right content** area
  # (e.g. a button) can be placed alongside the tab bar. Tab switching behavior is managed via a
  # Stimulus controller; the default controller name is `bulma-phlex--tabs`.
  #
  # Tabs and their content panels are added via the `tab` builder method. An optional right-side
  # element can be added via the `right_content` method.
  #
  # ## Example
  #
  #     render BulmaPhlex::Tabs.new do |tabs|
  #       tabs.tab(id: "profile", title: "Profile", active: true) do
  #         "Profile content goes here"
  #       end
  #
  #       tabs.tab(id: "settings", title: "Settings", icon: "fas fa-cog") do
  #         "Settings content goes here"
  #       end
  #
  #       tabs.tab(id: "notifications", title: "Notifications", icon: "fas fa-bell") do
  #         "Notifications content goes here"
  #       end
  #     end
  #
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

    # **Parameters**
    #
    # - `align` — Aligns the tabs: `"centered"` or `"right"`
    # - `size` — Sets the size of the tabs: `"small"`, `"medium"`, or `"large"`
    # - `boxed` — If `true`, uses classic boxed style tabs
    # - `toggle` — If `true`, makes the tabs look like buttons
    # - `rounded` — If `true`, makes the tabs look like rounded buttons (also enables toggle)
    # - `fullwidth` — If `true`, makes the tabs take up the full width of the container
    # - `data_attributes_builder` — Provides data attributes for Stimulus integration; defaults to
    #  `StimulusDataAttributes` with `"bulma-phlex--tabs"`
    # - `**html_attributes` — Additional HTML attributes for the outer `<div>` element
    def self.new(align: nil,
                 size: nil,
                 boxed: false,
                 toggle: false,
                 rounded: false,
                 fullwidth: false,
                 data_attributes_builder: StimulusDataAttributes.new("bulma-phlex--tabs"),
                 **html_attributes)
      super
    end

    def initialize(align: nil,
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

    # Adds a tab and its associated content panel. Can be called multiple times.
    #
    # - `id:` — A unique identifier for the tab, used to link the tab button to its content panel
    # - `title:` — The text label displayed on the tab button
    # - `icon:` — Optional icon class string (e.g. `"fas fa-cog"`) displayed alongside the title
    # - `active:` — If `true`, this tab is shown as selected on initial render (default: `false`)
    #
    # Expects a block that renders the content for this tab's panel.
    def tab(id:, title:, icon: nil, active: false, &)
      @tabs << TabComponents::Tab.new(id:, title:, icon:, active:,
                                      data_attributes_proc: @data_attributes_builder.method(:for_tab))
      @contents << TabComponents::Content.new(id:, active:,
                                              data_attributes_proc: @data_attributes_builder.method(:for_content),
                                              &)
    end

    # Sets optional content to render to the right of the tab bar (e.g. a button or action link).
    #
    # Expects a block that renders the right-side content.
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
          @tabs.each { |tab| render tab }
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
        @contents.each { |content| render content }
      end
    end
  end
end
