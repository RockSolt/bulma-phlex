# frozen_string_literal: true

module BulmaPhlex
  # Renders a [Bulma Dropdown](https://bulma.io/documentation/components/dropdown/) component.
  #
  # Supports options for **alignment** and **trigger icon**, and can operate in either click-to-toggle
  # or hover mode. Click mode integrates with a Stimulus controller; hover mode requires no JavaScript.
  #
  # ## Example
  #
  #     render BulmaPhlex::Dropdown.new("Next Actions...") do |dropdown|
  #       dropdown.link "View Profile", "/profile"
  #       dropdown.link "Go to Settings", "/settings"
  #       dropdown.divider
  #       dropdown.item("This is just a text item")
  #       dropdown.item do
  #         div(class: "has-text-weight-bold") { "This is a bold item" }
  #       end
  #     end
  class Dropdown < BulmaPhlex::Base
    # **Parameters**
    #
    # - `label` — The text displayed in the dropdown trigger button
    # - `click` — Stimulus controller name for toggling; set to `false` for hover mode instead
    # - `alignment` — Alignment of the dropdown menu: `"left"` (default), `"right"`, or `"up"`
    # - `icon` — Icon class for the trigger button (default: `"fas fa-angle-down"`)
    # - `**html_attributes` — Additional HTML attributes for the outermost dropdown element
    def self.new(label, click: "bulma-phlex--dropdown", alignment: "left", icon: "fas fa-angle-down",
                 **html_attributes)
      super
    end

    def initialize(label, click: "bulma-phlex--dropdown", alignment: "left", icon: "fas fa-angle-down",
                   **html_attributes)
      @label = label
      @click = click
      @alignment = alignment
      @icon = icon
      @html_attributes = html_attributes
    end

    def view_template(&)
      div(**mix({ class: dropdown_classes, **stimulus_controller }, @html_attributes)) do
        div(class: "dropdown-trigger") do
          button(
            class: "button",
            aria_haspopup: "true",
            aria_controls: "dropdown-menu",
            **stimulus_action
          ) do
            span { @label }
            span(class: "icon is-small") do
              i(class: @icon, aria_hidden: "true")
            end
          end
        end

        div(class: "dropdown-menu", id: "dropdown-menu", role: "menu") do
          div(class: "dropdown-content", &)
        end
      end
    end

    def item(content = nil, &)
      if block_given?
        div(class: "dropdown-item", &)
      else
        div(class: "dropdown-item") { content }
      end
    end

    def link(label, path)
      a(class: "dropdown-item", href: path) { label }
    end

    def divider
      hr(class: "dropdown-divider")
    end

    private

    def dropdown_classes
      classes = ["dropdown"]
      classes << "is-hoverable" unless @click
      classes << "is-#{@alignment}" unless @alignment == "left"
      classes.join(" ")
    end

    def alignment_class
      case @alignment.to_sym
      when :right
        "is-right"
      when :up
        "is-up"
      end
    end

    def stimulus_controller
      return {} unless @click

      { data: { controller: @click } }
    end

    def stimulus_action
      return {} unless @click

      { data: { action: "#{@click}#toggle" } }
    end
  end
end
