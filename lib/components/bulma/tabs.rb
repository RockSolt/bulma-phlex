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
      Tab = Data.define(:id, :title, :icon, :active)
      Content = Data.define(:id, :block, :active)

      def initialize(id: nil, tabs_class: nil, contents_class: nil, stimulus_controller: "bulma--tabs")
        @id = id || "tabs"
        @tabs_class = tabs_class
        @contents_class = contents_class
        @stimulus_controller = stimulus_controller
        @tabs = []
        @contents = []
      end

      def tab(id:, title:, icon: nil, active: false, &block)
        @tabs << Tab.new(id:, title:, icon:, active:)
        @contents << Content.new(id:, block:, active:)
      end

      def right_content(&content)
        @right_content = content
      end

      def view_template(&)
        vanish(&)

        div(id: @id, data: { controller: @stimulus_controller }) do
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
        div(id: "#{@id}-tabs", class: "tabs #{@tabs_class}".strip) do
          ul do
            @tabs.each do |tab|
              li(
                id: "#{tab.id}-tab",
                data: {
                  target_key => "tab",
                  tab_content: tab.id,
                  action: "click->#{@stimulus_controller}#showTabContent"
                },
                class: tab.active ? "is-active" : ""
              ) do
                a do
                  icon_span(tab.icon, "mr-1") if tab.icon
                  span { tab.title }
                end
              end
            end
          end
        end
      end

      def build_content
        @contents.each do |content|
          div(id: content.id,
              class: content.active ? "" : "is-hidden",
              data: { target_key => "content" }) do
            content.block.call
          end
        end
      end

      def target_key
        "#{@stimulus_controller}-target"
      end
    end
  end
end
