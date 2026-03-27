# frozen_string_literal: true

module BulmaPhlex
  # Renders a [Bulma card](https://bulma.io/documentation/components/card/) component.
  #
  # Supports an optional **header** (with title and custom classes), a **content** area, and a
  # **footer** with one or more link items (which can include icons). Each section is populated
  # via builder methods on the yielded component.
  #
  # ## Example
  #
  #     render BulmaPhlex::Card.new do |card|
  #       card.head("Card Title")
  #       card.content do
  #         "This is some card content"
  #       end
  #       card.footer_link("View", "/view", target: "_blank")
  #       card.footer_link("Edit", "/edit", class: "has-text-primary")
  #     end
  class Card < BulmaPhlex::Base
    # **Parameters**
    #
    # - `**html_attributes` — Additional HTML attributes for the card element
    def self.new(**html_attributes)
      super
    end

    def initialize(**html_attributes)
      @html_attributes = html_attributes
    end

    def view_template(&)
      vanish(&)

      div(**mix(class: "card", **@html_attributes)) do
        card_header
        card_content
        card_footer
      end
    end

    # Sets the card header title and optional CSS classes.
    #
    # - `title` — The text to display in the card header
    # - `classes` — Optional additional CSS classes for the header element
    def head(title, classes: nil)
      @header_title = title
      @header_classes = classes
    end

    # Sets the card body content.
    #
    # Expects a block that renders the card content.
    def content(&block)
      @card_content = block
    end

    # Adds a link item to the card footer. Can be called multiple times to add multiple links.
    #
    # - `text` — The link label text
    # - `href` — The URL the link points to
    # - `icon:` — Optional icon class string (e.g. `"fas fa-edit"`) to render an icon alongside the text
    # - `**html_attributes` — Additional HTML attributes for the `<a>` element (e.g. `target:`, `class:`)
    def footer_link(text, href, **html_attributes)
      (@footer_items ||= []) << [text, href, html_attributes]
    end

    # Delegates full control of the footer item to the block. The top element in the block must include
    # the `card-footer-item` class.
    def footer_item(&block)
      (@footer_items ||= []) << block
    end

    private

    def card_header
      return if @header_title.nil?

      header(class: "card-header #{@header_classes}") do
        p(class: "card-header-title") { plain @header_title }
      end
    end

    def card_content
      return if @card_content.nil?

      div(class: "card-content") do
        div(class: "content") { @card_content.call }
      end
    end

    def card_footer
      return if @footer_items.nil? || @footer_items.empty?

      footer(class: "card-footer") do
        @footer_items.each do |block_or_text, href, html_attributes|
          if block_or_text.is_a?(Proc)
            block_or_text.call
          else
            render_footer_link(block_or_text, href, html_attributes)
          end
        end
      end
    end

    def render_footer_link(text, href, html_attributes)
      icon = html_attributes.delete(:icon)
      html_attributes[:class] = [html_attributes[:class], "card-footer-item"].compact.join(" ")
      a(href:, **html_attributes) do
        if icon.nil?
          plain text
        else
          icon_text(icon, text)
        end
      end
    end

    def icon_text(icon, text)
      span(class: "icon-text") do
        span(class: "icon") { i(class: icon) }
        span { text }
      end
    end
  end
end
