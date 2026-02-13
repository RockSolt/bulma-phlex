# frozen_string_literal: true

require "test_helper"

module BulmaPhlex
  class TabsTest < Minitest::Test
    include TagOutputAssertions

    def test_renders_tabs_with_content
      component = BulmaPhlex::Tabs.new

      result = component.call do |tabs|
        assign_two_tabs(tabs)
      end

      expected_structure = <<~HTML
        <div data-controller="bulma-phlex--tabs">
          <div class="tabs">
            <ul>
              <li id="tab1-tab" data-bulma-phlex--tabs-target="tab" data-tab-content="tab1" data-action="click->bulma-phlex--tabs#showTabContent" class="is-active">
                <a><span>Tab 1</span></a>
              </li>
              <li id="tab2-tab" data-bulma-phlex--tabs-target="tab" data-tab-content="tab2" data-action="click->bulma-phlex--tabs#showTabContent" class="">
                <a><span>Tab 2</span></a>
              </li>
            </ul>
          </div>

          <div>
            <div id="tab1" class="" data-bulma-phlex--tabs-target="content">Content for Tab 1</div>
            <div id="tab2" class="is-hidden" data-bulma-phlex--tabs-target="content">Content for Tab 2</div>
          </div>
        </div>
      HTML

      assert_html_equal expected_structure, result
    end

    def test_renders_tabs_with_flex_right
      component = BulmaPhlex::Tabs.new

      result = component.call do |tabs|
        assign_two_tabs(tabs)
        tabs.right_content { "ON THE RIGHT" }
      end

      assert_html_equal <<~HTML, result
        <div data-controller="bulma-phlex--tabs">
          <div class="columns">
            <div class="column">
              <div class="tabs">
              <ul>
                  <li id="tab1-tab" data-bulma-phlex--tabs-target="tab" data-tab-content="tab1" data-action="click->bulma-phlex--tabs#showTabContent" class="is-active">
                  <a><span>Tab 1</span></a>
                  </li>
                  <li id="tab2-tab" data-bulma-phlex--tabs-target="tab" data-tab-content="tab2" data-action="click->bulma-phlex--tabs#showTabContent" class="">
                  <a><span>Tab 2</span></a>
                  </li>
              </ul>
              </div>
            </div>
            <div class="column is-narrow">ON THE RIGHT</div>
          </div>

          <div>
            <div id="tab1" class="" data-bulma-phlex--tabs-target="content">Content for Tab 1</div>
            <div id="tab2" class="is-hidden" data-bulma-phlex--tabs-target="content">Content for Tab 2</div>
          </div>
        </div>
      HTML
    end

    def test_boxed
      component = BulmaPhlex::Tabs.new(boxed: true)

      result = component.call do |tabs|
        tabs.tab(id: "tab1", title: "Settings", icon: "fas fa-cog") do
          "Settings content"
        end
      end

      assert_html_includes result, '<div class="tabs is-boxed">'
    end

    def test_align_centered
      component = BulmaPhlex::Tabs.new(align: :centered)

      result = component.call do |tabs|
        tabs.tab(id: "tab1", title: "Settings", icon: "fas fa-cog") do
          "Settings content"
        end
      end

      assert_html_includes result, '<div class="tabs is-centered">'
    end

    def test_align_right
      component = BulmaPhlex::Tabs.new(align: :right)

      result = component.call do |tabs|
        tabs.tab(id: "tab1", title: "Settings", icon: "fas fa-cog") do
          "Settings content"
        end
      end

      assert_html_includes result, '<div class="tabs is-right">'
    end

    def test_size
      component = BulmaPhlex::Tabs.new(size: "small")

      result = component.call do |tabs|
        tabs.tab(id: "tab1", title: "Settings", icon: "fas fa-cog") do
          "Settings content"
        end
      end

      assert_html_includes result, '<div class="tabs is-small">'
    end

    def test_toggle
      component = BulmaPhlex::Tabs.new(toggle: true)

      result = component.call do |tabs|
        tabs.tab(id: "tab1", title: "Settings", icon: "fas fa-cog") do
          "Settings content"
        end
      end

      assert_html_includes result, '<div class="tabs is-toggle">'
    end

    def test_rounded
      component = BulmaPhlex::Tabs.new(rounded: true)

      result = component.call do |tabs|
        tabs.tab(id: "tab1", title: "Settings", icon: "fas fa-cog") do
          "Settings content"
        end
      end

      assert_html_includes result, '<div class="tabs is-toggle is-toggle-rounded">'
    end

    def test_fullwidth
      component = BulmaPhlex::Tabs.new(fullwidth: true)

      result = component.call do |tabs|
        tabs.tab(id: "tab1", title: "Settings", icon: "fas fa-cog") do
          "Settings content"
        end
      end

      assert_html_includes result, '<div class="tabs is-fullwidth">'
    end

    def test_renders_tabs_with_icons
      component = BulmaPhlex::Tabs.new

      result = component.call do |tabs|
        tabs.tab(id: "tab1", title: "Settings", icon: "fas fa-cog") do
          "Settings content"
        end
      end

      assert_html_includes result, '<span class="icon mr-1"><i class="fas fa-cog"></i></span>'
      assert_html_includes result, "<span>Settings</span>"
    end

    def test_with_additional_html_attributes
      component = BulmaPhlex::Tabs.new(id: "my-tabs", data: { custom: "value" })

      result = component.call do |tabs|
        tabs.tab(id: "tab1", title: "Settings", icon: "fas fa-cog") do
          "Settings content"
        end
      end

      assert_html_includes result, '<div data-controller="bulma-phlex--tabs" data-custom="value" id="my-tabs"'
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
