# frozen_string_literal: true

module BulmaPhlex
  # Card component for content display
  #
  # This component implements the [Bulma card](https://bulma.io/documentation/components/card/)
  # interface. Cards are flexible containers that can display various types of content
  # including headers, content sections, and more.
  #
  # ## Example
  #
  # ```ruby
  # BulmaPhex::Card() do |card|
  #   card.head("Card Title")
  #   card.content do
  #     "This is some card content"
  #   end
  #   card.footer_link("View", "/view", target: "_blank")
  #   card.footer_link("Edit", "/edit", class: "has-text-primary")
  # end
  # ```
  class Card < BulmaPhlex::Base
    def view_template(&)
      vanish(&)

      div(class: "card") do
        card_header
        card_content
        card_footer
      end
    end

    def head(title, classes: nil)
      @header_title = title
      @header_classes = classes
    end

    def content(&block)
      @card_content = block
    end

    def footer_link(text, href, **html_attributes)
      (@footer_items ||= []) << [text, href, html_attributes]
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
        @footer_items.each do |text, href, html_attributes|
          html_attributes[:class] = [html_attributes[:class], "card-footer-item"].compact.join(" ")
          a(href:, **html_attributes) { text }
        end
      end
    end
  end
end
