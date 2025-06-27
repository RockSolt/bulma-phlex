# frozen_string_literal: true

module Components
  module Bulma
    # Tabs component for toggling between different content sections
    #
    # This component implements the [Bulma tabs](https://bulma.io/documentation/components/tabs/)
    # interface, providing a way to toggle between different content sections using
    # tabbed navigation. Includes support for icons and active state management.
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

      def initialize
        @tabs = []
        @contents = []
      end

      def tab(id:, title:, icon: nil, active: false, &block)
        @tabs << Tab.new(id:, title:, icon:, active:)
        @contents << Content.new(id:, block:, active:)
      end

      def view_template(&)
        vanish(&)

        div(data: { controller: "tabs" }) do
          div(class: "tabs is-boxed") do
            ul do
              @tabs.each do |tab|
                li(
                  id: "#{tab.id}-tab",
                  data: {
                    tabs_target: "tab",
                    tab_content: tab.id,
                    action: "click->tabs#showTabContent"
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

          @contents.each do |content|
            div(id: content.id,
                class: content.active ? "" : "hidden",
                data: { tabs_target: "content" }) do
              content.block.call
            end
          end
        end
      end
    end
  end
end
