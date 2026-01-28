# frozen_string_literal: true

require "test_helper"

module BulmaPhlex
  class NotificationTest < Minitest::Test
    include TagOutputAssertions

    def test_renders_notification_with_string_content
      component = BulmaPhlex::Notification.new
      result = component.call do
        "Notification content."
      end

      expected_html = <<~HTML
        <div class="notification">
          Notification content.
        </div>
      HTML

      assert_html_equal expected_html, result
    end

    def test_renders_notification_with_block_content
      component = BulmaPhlex::Notification.new
      result = component.call do |c|
        c.p { "Hello, World!" }
      end

      expected_html = <<~HTML
        <div class="notification">
          <p>Hello, World!</p>
        </div>
      HTML

      assert_html_equal expected_html, result
    end

    def test_renders_with_delete
      component = BulmaPhlex::Notification.new(delete: true)
      result = component.call do |c|
        c.p { "Dismissible notification." }
      end

      assert_html_equal <<~HTML, result
        <div class="notification">
          <button class="delete"></button>
          <p>Dismissible notification.</p>
        </div>
      HTML
    end

    def test_renders_with_color
      component = BulmaPhlex::Notification.new(color: "primary")
      results = component.call do |c|
        c.p { "Primary notification." }
      end

      assert_html_equal <<~HTML, results
        <div class="notification is-primary">
          <p>Primary notification.</p>
        </div>
      HTML
    end

    def test_renders_light_color
      component = BulmaPhlex::Notification.new(color: "primary", mode: "light")
      results = component.call do |c|
        c.p { "Primary notification." }
      end

      assert_html_equal <<~HTML, results
        <div class="notification is-primary is-light">
          <p>Primary notification.</p>
        </div>
      HTML
    end

    def test_with_data_attributes_for_delete
      component = BulmaPhlex::Notification.new(delete: { data: { action: "notification#close" } })
      result = component.call do |c|
        c.p { "Notification with data attributes." }
      end

      expected_html = <<~HTML
        <div class="notification">
          <button class="delete" data-action="notification#close"></button>
          <p>Notification with data attributes.</p>
        </div>
      HTML

      assert_html_equal expected_html, result
    end

    def test_with_additional_classes
      component = BulmaPhlex::Notification.new(class: "custom-class another-class", color: "info")
      result = component.call do |c|
        c.p { "Notification with additional classes." }
      end

      expected_html = <<~HTML
        <div class="notification is-info custom-class another-class">
          <p>Notification with additional classes.</p>
        </div>
      HTML
      assert_html_equal expected_html, result
    end

    def test_with_id
      component = BulmaPhlex::Notification.new(delete: true, id: "custom-notification", color: "primary")
      result = component.call do |c|
        c.p { "Notification with custom ID." }
      end

      expected_html = <<~HTML
        <div class="notification is-primary" id="custom-notification">
          <button class="delete"></button>
          <p>Notification with custom ID.</p>
        </div>
      HTML

      assert_html_equal expected_html, result
    end

    def test_with_additional_classes_on_delete_button
      component = BulmaPhlex::Notification.new(delete: { class: "custom-delete-class" }, color: "warning")
      result = component.call do |c|
        c.p { "Notification with custom delete button class." }
      end

      expected_html = <<~HTML
        <div class="notification is-warning">
          <button class="delete custom-delete-class"></button>
          <p>Notification with custom delete button class.</p>
        </div>
      HTML

      assert_html_equal expected_html, result
    end
  end
end
