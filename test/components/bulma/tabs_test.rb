# frozen_string_literal: true

require "test_helper"

module Components
  module Bulma
    class TabsTest < Minitest::Test
      include TagOutputAssertions

      def test_renders_tabs_with_content
        component = Components::Bulma::Tabs.new

        result = component.call do |tabs|
          tabs.tab(id: "tab1", title: "Tab 1", active: true) do
            "Content for Tab 1"
          end

          tabs.tab(id: "tab2", title: "Tab 2") do
            "Content for Tab 2"
          end
        end

        expected_structure = <<~HTML
          <div data-controller="tabs">
            <div class="tabs is-boxed">
              <ul>
                <li data-tabs-target="tab" data-tab-content="tab1" data-action="click->tabs#showTabContent" class="is-active">
                  <a><span>Tab 1</span></a>
                </li>
                <li data-tabs-target="tab" data-tab-content="tab2" data-action="click->tabs#showTabContent" class="">
                  <a><span>Tab 2</span></a>
                </li>
              </ul>
            </div>
            <div id="tab1" class="" data-tabs-target="content">Content for Tab 1</div>
            <div id="tab2" class="hidden" data-tabs-target="content">Content for Tab 2</div>
          </div>
        HTML

        assert_dom_equal expected_structure, result
      end

      def test_renders_tabs_with_icons
        component = Components::Bulma::Tabs.new

        result = component.call do |tabs|
          tabs.tab(id: "tab1", title: "Settings", icon: "fas fa-cog") do
            "Settings content"
          end
        end

        assert_html_includes result, '<span class="icon mr-1"><i class="fas fa-cog"></i></span>'
        assert_html_includes result, "<span>Settings</span>"
      end
    end
  end
end
