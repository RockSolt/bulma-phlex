# frozen_string_literal: true

module BulmaPhlex
  # Dropdown component
  #
  # This component implements the [Bulma Dropdown](https://bulma.io/documentation/components/dropdown/).
  #
  # ## [Hoverable or Toggable](https://bulma.io/documentation/components/dropdown/#hoverable-or-toggable)
  #
  # By default the dropdown is in Click Mode and assumes a Stimulus controller named `bulma-phlex--dropdown` is present
  # to handle the click events. The controller name can be customized using the `click` option.
  #
  # Set click to `false` to make the dropdown hoverable instead of togglable.
  #
  # ## Alignment
  #
  # Use the `alignment` option to control the dropdown's alignment. By default, it aligns to the left. Pass in
  # `:right` or `:up` to change the alignment.
  #
  # ## Icon
  #
  # Use the `icon` option to customize the dropdown's icon. By default, it uses the Font Awesome angle down icon.
  #
  # ## Example
  #
  # ```ruby
  # BulmaPhex::Dropdown("Next Actions...") do |dropdown|
  #   dropdown.link "View Profile", "/profile"
  #   dropdown.link "Go to Settings", "/settings"
  #   dropdown.divider
  #   dropdown.item("This is just a text item")
  #   dropdown.item do
  #     div(class: "has-text-weight-bold") { "This is a bold item" }
  #   end
  # end
  # ```
  #
  class Dropdown < BulmaPhlex::Base
    def initialize(label, click: "bulma-phlex--dropdown", alignment: "left", icon: "fas fa-angle-down")
      @label = label
      @click = click
      @alignment = alignment
      @icon = icon
    end

    def view_template(&)
      div(class: "dropdown #{"is-hoverable" unless @click} #{alignment_class}".strip, **stimulus_controller) do
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
