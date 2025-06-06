# frozen_string_literal: true

require "test_helper"

module Components
  module Bulma
    class CardTest < Minitest::Test
      include TagOutputAssertions

      def test_renders_basic_card
        component = Components::Bulma::Card.new

        result = component.call do |card|
          card.head("Card Title")
          card.content do
            "This is some card content"
          end
        end

        expected_html = <<~HTML
          <div class="card">
            <header class="card-header ">
              <p class="card-header-title">Card Title</p>
            </header>
            <div class="card-content">
              <div class="content">This is some card content</div>
            </div>
          </div>
        HTML

        assert_html_equal expected_html, result
      end

      def test_head_with_custom_classes
        component = Components::Bulma::Card.new

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

      def test_turbo_frame_content_when_rails_available
        # Skip this test if Phlex::Rails is not available
        skip unless defined?(Phlex::Rails)

        component = Components::Bulma::Card.new

        result = component.call do |card|
          card.turbo_frame_content("my-frame", src: "/some-path")
        end

        expected_html = <<~HTML
          <div class="card">
            <div class="card-content">
              <div class="content">
                <turbo-frame id="my-frame" src="/some-path">
                  <span class="icon"><i class="fas fa-spinner fa-pulse"></i></span>
                  <span>Loading...</span>
                </turbo-frame>
              </div>
            </div>
          </div>
        HTML

        assert_html_equal expected_html, result
      end

      def test_turbo_frame_content_with_custom_pending_message
        # Skip this test if Phlex::Rails is not available
        skip unless defined?(Phlex::Rails)

        component = Components::Bulma::Card.new

        result = component.call do |card|
          card.turbo_frame_content("my-frame", pending_message: "Please wait...")
        end

        expected_html = <<~HTML
          <div class="card">
            <div class="card-content">
              <div class="content">
                <turbo-frame id="my-frame">
                  <span class="icon"><i class="fas fa-spinner fa-pulse"></i></span>
                  <span>Please wait...</span>
                </turbo-frame>
              </div>
            </div>
          </div>
        HTML

        assert_html_equal expected_html, result
      end
    end
  end
end
