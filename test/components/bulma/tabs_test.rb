# frozen_string_literal: true

require "test_helper"

module Components
  module Bulma
    class TabsTest < Minitest::Test
      include TagOutputAssertions

      def test_renders_tabs_with_content
        component = Components::Bulma::Tabs.new

        result = component.call do |tabs|
          assign_two_tabs(tabs)
        end

        expected_structure = <<~HTML
          <div data-controller="bulma--tabs">
            <div class="tabs">
              <ul>
                <li id="tab1-tab" data-bulma--tabs-target="tab" data-tab-content="tab1" data-action="click->bulma--tabs#showTabContent" class="is-active">
                  <a><span>Tab 1</span></a>
                </li>
                <li id="tab2-tab" data-bulma--tabs-target="tab" data-tab-content="tab2" data-action="click->bulma--tabs#showTabContent" class="">
                  <a><span>Tab 2</span></a>
                </li>
              </ul>
            </div>

            <div>
              <div id="tab1" class="" data-bulma--tabs-target="content">Content for Tab 1</div>
              <div id="tab2" class="is-hidden" data-bulma--tabs-target="content">Content for Tab 2</div>
            </div>
          </div>
        HTML

        assert_html_equal expected_structure, result
      end

      def test_renders_tabs_with_flex_right
        component = Components::Bulma::Tabs.new

        result = component.call do |tabs|
          assign_two_tabs(tabs)
          tabs.right_content { "ON THE RIGHT" }
        end

        expected_structure = <<~HTML
          <div data-controller="bulma--tabs">
            <div class="columns">
              <div class="column">
                <div class="tabs">
                <ul>
                    <li id="tab1-tab" data-bulma--tabs-target="tab" data-tab-content="tab1" data-action="click->bulma--tabs#showTabContent" class="is-active">
                    <a><span>Tab 1</span></a>
                    </li>
                    <li id="tab2-tab" data-bulma--tabs-target="tab" data-tab-content="tab2" data-action="click->bulma--tabs#showTabContent" class="">
                    <a><span>Tab 2</span></a>
                    </li>
                </ul>
                </div>
              </div>
              <div class="column is-narrow">ON THE RIGHT</div>
            </div>

            <div>
              <div id="tab1" class="" data-bulma--tabs-target="content">Content for Tab 1</div>
              <div id="tab2" class="is-hidden" data-bulma--tabs-target="content">Content for Tab 2</div>
            </div>
          </div>
        HTML

        assert_html_equal expected_structure, result
      end

      def test_tabs_class
        component = Components::Bulma::Tabs.new(tabs_class: "is-boxed")

        result = component.call do |tabs|
          tabs.tab(id: "tab1", title: "Settings", icon: "fas fa-cog") do
            "Settings content"
          end
        end

        assert_html_includes result, '<div class="tabs is-boxed">'
      end

      def test_contents_class
        component = Components::Bulma::Tabs.new(contents_class: "ml-4")

        result = component.call do |tabs|
          tabs.tab(id: "tab1", title: "Settings", icon: "fas fa-cog") do
            "Settings content"
          end
        end

        assert_html_includes result, '<div class="ml-4">'
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

      private

      def assign_two_tabs(tabs)
        tabs.tab(id: "tab1", title: "Tab 1", active: true) do
          "Content for Tab 1"
        end

        tabs.tab(id: "tab2", title: "Tab 2") do
          "Content for Tab 2"
        end
      end
    end
  end
end
