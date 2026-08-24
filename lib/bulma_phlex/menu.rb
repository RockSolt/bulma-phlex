# frozen_string_literal: true

module BulmaPhlex
  # Renders a [Bulma menu](https://bulma.io/documentation/components/menu/) component with a label and list of items.
  #
  # The menu supports headers with the `label` method, lists with the `list` method, and items with the `item` method.
  # If an item has nested items, use a block within the `item` method to add the nested items. An item can be marked as
  # active by passing `active: true` to the `item` method.
  #
  # Additional HTML attributes can be passed to the constructor as well as any of the methods.
  #
  # ## Example
  #
  #     render BulmaPhlex::Menu.new do |menu|
  #       menu.label "General"
  #       menu.list do |list|
  #         list.item "Dashboard", href: "#dashboard"
  #         list.item "Customers", href: "#customers" do |nested|
  #           nested.item "Active Customers", href: "#active-customers"
  #           nested.item "Inactive Customers", href: "#inactive-customers"
  #         end
  #       end
  #     end
  class Menu < BulmaPhlex::Base
    # **Parameters**
    #
    # - `**html_attributes` — Additional HTML attributes for the menu element
    def self.new(**html_attributes)
      super
    end

    def initialize(**html_attributes)
      @html_attributes = html_attributes
    end

    def view_template(&)
      aside(**mix({ class: "menu" }, @html_attributes)) do
        yield(self) if block_given?
      end
    end

    # Adds a header label to the menu. Additional HTML attributes can be passed to customize the label element.
    def label(text, **attributes)
      p(**mix({ class: "menu-label" }, attributes)) { text }
    end

    # Pass a block to add a list of items to the menu. Additional HTML attributes can be passed to customize the
    # list element.
    def list(**attributes, &)
      ul(**mix({ class: "menu-list" }, attributes)) do
        yield(self) if block_given?
      end
    end

    # Adds an item to the menu list. The `href` parameter is required to specify the link for the item. If the item is
    # active, pass `active: true`. Additional HTML attributes can be passed to customize the link element. If the item
    # has nested items, pass a block to add the nested items.
    def item(label, href:, active: false, **attributes, &)
      li_attributes, attributes = parse_li_attributes(attributes)

      li(**li_attributes) do
        attributes = mix({ class: "is-active" }, attributes) if active
        a(**mix({ href: }, attributes)) { label }
        nested_list(&) if block_given?
      end
    end

    def expandable_item(label, open: false, **attributes, &)
      li_attributes, attributes = parse_li_attributes(attributes)

      li(**li_attributes) do
        details(open:) do
          summary(**mix({ class: "menu-item is-clickable" }, attributes)) { label }
          nested_list(&)
        end
      end
    end

    private

    def parse_li_attributes(attributes)
      if attributes.key?(:li_attributes)
        [attributes[:li_attributes], attributes.except(:li_attributes)]
      else
        [{}, attributes]
      end
    end

    def nested_list(&)
      ul(class: "menu-list") do
        yield(self)
      end
    end
  end
end
