# frozen_string_literal: true

require "test_helper"

module BulmaPhlex
  class CardTest < Minitest::Test
    include TagOutputAssertions

    def test_renders_basic_card
      component = BulmaPhlex::Card.new

      result = component.call do |card|
        card.header("Card Title")
        card.content do
          "This is some card content"
        end
        card.footer_link("Footer Link", "/footer-link")
      end

      expected_html = <<~HTML
        <div class="card">
          <header class="card-header">
            <p class="card-header-title">Card Title</p>
          </header>
          <div class="card-content">
            This is some card content
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
        Gem::Deprecate.skip_during do
          card.head("Custom Header", classes: "is-primary")
        end
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

    def test_header_with_title
      component = BulmaPhlex::Card.new

      result = component.call do |card|
        card.header("Card Header")
      end

      expected_html = <<~HTML
        <div class="card">
          <header class="card-header">
            <p class="card-header-title">Card Header</p>
          </header>
        </div>
      HTML

      assert_html_equal expected_html, result
    end

    def test_header_with_additional_attributes
      component = BulmaPhlex::Card.new

      result = component.call do |card|
        card.header("Card Header", class: "is-primary", data: { test: "value" })
      end

      expected_html = <<~HTML
        <div class="card">
          <header class="card-header is-primary" data-test="value">
            <p class="card-header-title">Card Header</p>
          </header>
        </div>
      HTML

      assert_html_equal expected_html, result
    end

    def test_header_with_block
      component = BulmaPhlex::Card.new

      result = component.call do |card|
        card.header do
          card.p(class: "card-header-title sale") { "On Sale" }
        end
      end

      expected_html = <<~HTML
        <div class="card">
          <header class="card-header">
            <p class="card-header-title sale">On Sale</p>
          </header>
        </div>
      HTML

      assert_html_equal expected_html, result
    end

    def test_header_with_title_and_block
      component = BulmaPhlex::Card.new

      result = component.call do |card|
        card.header("Card Header") do
          card.p(class: "subtitle") { "On Sale" }
        end
      end

      assert_html_equal <<~HTML, result
        <div class="card">
          <header class="card-header">
            <p class="card-header-title">Card Header</p>
            <p class="subtitle">On Sale</p>
          </header>
        </div>
      HTML
    end

    def test_with_image
      component = BulmaPhlex::Card.new

      result = component.call do |card|
        card.image(src: "image.jpg", alt: "An image", size: 128, rounded: true)
      end

      assert_html_equal <<~HTML, result
        <div class="card">
          <div class="card-image">
            <figure class="image is-128x128">
              <img src="image.jpg" alt="An image" class="is-rounded"/>
            </figure>
          </div>
        </div>
      HTML
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

    def test_footer_with_icons
      component = BulmaPhlex::Card.new

      result = component.call do |card|
        card.footer_link("Profile", "/profile", icon: "fas fa-user")
      end

      expected_html = <<~HTML
        <div class="card">
          <footer class="card-footer">
            <a href="/profile" class="card-footer-item">
              <span class="icon-text">
                <span class='icon'>
                  <i class='fas fa-user'></i>
                </span>
                <span>Profile</span>
              </span>
            </a>
          </footer>
        </div>
      HTML

      assert_html_equal expected_html, result
    end

    def test_with_additional_html_attributes
      component = BulmaPhlex::Card.new(id: "my-card", data: { test: "value" })

      result = component.call do |card|
        card.header("Card with Attributes")
      end

      expected_html = <<~HTML
        <div class="card" id="my-card" data-test="value">
          <header class="card-header">
            <p class="card-header-title">Card with Attributes</p>
          </header>
        </div>
      HTML

      assert_html_equal expected_html, result
    end

    def test_with_additional_classes
      component = BulmaPhlex::Card.new(class: "approved")
      result = component.call do |card|
        card.header("Card with Additional Classes")
      end

      assert_html_equal <<~HTML, result
        <div class="card approved">
          <header class="card-header">
            <p class="card-header-title">Card with Additional Classes</p>
          </header>
        </div>
      HTML
    end

    def test_footer_items
      component = BulmaPhlex::Card.new

      result = component.call do |card|
        card.footer_item do
          card.a(href: "https://www.linkedin.com/in/rockridgesolutions", class: "card-footer-item") do
            card.img(src: "images/LI-In-Bug.png", class: "linked-in-logo", alt: "LinkedIn Logo")
          end
        end
      end

      assert_html_equal <<~HTML, result
        <div class="card">
          <footer class="card-footer">
            <a href="https://www.linkedin.com/in/rockridgesolutions" class="card-footer-item">
              <img src="images/LI-In-Bug.png" class="linked-in-logo" alt="LinkedIn Logo">
            </a>
          </footer>
        </div>
      HTML
    end
  end
end
