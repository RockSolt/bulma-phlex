# frozen_string_literal: true

require "test_helper"

module Components
  module Bulma
    class CardTest < Minitest::Test
      include TagOutputAssertions

      def test_renders_basic_card
        component = BulmaPhlex::Card.new

        result = component.call do |card|
          card.head("Card Title")
          card.content do
            "This is some card content"
          end
          card.footer_link("Footer Link", "/footer-link")
        end

        expected_html = <<~HTML
          <div class="card">
            <header class="card-header ">
              <p class="card-header-title">Card Title</p>
            </header>
            <div class="card-content">
              <div class="content">This is some card content</div>
            </div>
            <footer class="card-footer">
              <a href="/footer-link" class="card-footer-item">Footer Link</a>
            </footer>
          </div>
        HTML

        assert_html_equal expected_html, result
      end

      def test_head_with_custom_classes
        component = BulmaPhlex::Card.new

        result = component.call do |card|
          card.head("Custom Header", classes: "is-primary")
        end

        expected_html = <<~HTML
          <div class="card">
            <header class="card-header is-primary">
              <p class="card-header-title">Custom Header</p>
            </header>
          </div>
        HTML

        assert_html_equal expected_html, result
      end

      def test_footer_with_links
        component = BulmaPhlex::Card.new

        result = component.call do |card|
          card.footer_link("Footer Link", "/footer-link", data: { test: "value" })
          card.footer_link("Link 2", "/link-2", class: "is-uppercase", target: "_blank")
        end

        expected_html = <<~HTML
          <div class="card">
            <footer class="card-footer">
              <a href="/footer-link" class="card-footer-item" data-test="value">Footer Link</a>
              <a href="/link-2" class="is-uppercase card-footer-item" target="_blank">Link 2</a>
            </footer>
          </div>
        HTML

        assert_html_equal expected_html, result
      end
    end
  end
end
