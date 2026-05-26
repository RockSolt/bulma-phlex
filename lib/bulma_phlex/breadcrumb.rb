# frozen_string_literal: true

module BulmaPhlex
  # Renders a [Bulma breadcrumb](https://bulma.io/documentation/components/breadcrumb/) component.
  # It supports options for **alignment** (centered, right-aligned), **separator** style (arrow,
  # bullet, dot, or succeeds (greater than)), and **size** (small, medium, large).
  class Breadcrumb < Base
    # **Parameters**
    #
    # - `align` — Breadcrumb alignment: `"centered"` or `"right"`
    # - `separator` — Breadcrumb separator style: `"arrow"`, `"bullet"`, `"dot"`, or `"succeeds"`
    # - `size` — Alternate size: `"small"`, `"medium"`, or `"large"`
    # - `**html_attributes` — Additional HTML attributes for the `<nav>` element
    def self.new(align: nil, separator: nil, size: nil, **html_attributes)
      super
    end

    def initialize(align: nil, separator: nil, size: nil, **html_attributes)
      @align = align
      @separator = separator
      @size = size
      @html_attributes = html_attributes

      @items = []
    end

    def view_template(&)
      vanish(&)
      return if @items.empty?

      nav(**mix(@html_attributes, class: nav_classes, aria: { label: "breadcrumbs" })) do
        ul do
          @items[0...-1].each do |item|
            render_item(item)
          end

          render_last_item
        end
      end
    end

    # Adds a breadcrumb item to the component. The last item added will be rendered as the active item.
    #
    # **Parameters**
    # - `label` (positional) — The text label for the breadcrumb item
    # - `href` — URL for the breadcrumb item; not required on last item / current page
    # - `icon` — Optional icon class for the breadcrumb item (e.g. `"fa-solid fa-home"`)
    def item(label, href: nil, icon: nil)
      @items << { label:, icon:, html_attributes: { href: href } }
    end

    private

    def nav_classes
      classes = ["breadcrumb"]
      classes << "is-#{@align}" if @align
      classes << "has-#{@separator}-separator" if @separator
      classes << "is-#{@size}" if @size
      classes
    end

    def render_item(item, list_item_attributes: {})
      li(**list_item_attributes) do
        a(**item[:html_attributes]) do
          if item[:icon]
            render BulmaPhlex::Icon.new(item[:icon], size: "small", icon_attributes: { aria: { hidden: "true" } })
            span { item[:label] }
          else
            plain item[:label]
          end
        end
      end
    end

    def render_last_item
      item = @items.last

      item[:html_attributes] = mix(item[:html_attributes], aria: { current: "page" })
      render_item(item, list_item_attributes: { class: "is-active" })
    end
  end
end
