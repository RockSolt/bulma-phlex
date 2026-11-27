# frozen_string_literal: true

require "test_helper"

module BulmaPhlex
  class MessageTest < Minitest::Test
    include TagOutputAssertions

    def test_message
      component = Message.new("The Header")

      assert_html_equal(<<~HTML, component.call { "The content." })
        <article class="message">
          <div class="message-header">
            <p>The Header</p>
          </div>
          <div class="message-body">
            The content.
          </div>
        </article>
      HTML
    end

    def test_with_delete
      component = Message.new("The Header", delete: true)

      assert_html_equal(<<~HTML, component.call { "The content." })
        <article class="message">
          <div class="message-header">
            <p>The Header</p>
            <button class="delete" aria-label="delete"></button>
          </div>
          <div class="message-body">
            The content.
          </div>
        </article>
      HTML
    end

    def test_with_delete_hash
      delete = { data: { controller: "delete-me" } }
      component = Message.new("The Header", delete:)

      assert_html_equal(<<~HTML, component.call { "The content." })
        <article class="message">
          <div class="message-header">
            <p>The Header</p>
            <button class="delete" aria-label="delete" data-controller="delete-me"></button>
          </div>
          <div class="message-body">
            The content.
          </div>
        </article>
      HTML
    end

    def test_with_color
      component = Message.new("The Header", color: "info")

      assert_html_equal(<<~HTML, component.call { "The informational content." })
        <article class="message is-info">
          <div class="message-header">
            <p>The Header</p>
          </div>
          <div class="message-body">
            The informational content.
          </div>
        </article>
      HTML
    end

    def test_with_size
      component = Message.new("The Header", size: "large")

      assert_html_equal(<<~HTML, component.call { "The large content." })
        <article class="message is-large">
          <div class="message-header">
            <p>The Header</p>
          </div>
          <div class="message-body">
            The large content.
          </div>
        </article>
      HTML
    end

    def test_without_header
      component = Message.new

      assert_html_equal(<<~HTML, component.call { "There is no header." })
        <article class="message">
          <div class="message-body">
            There is no header.
          </div>
        </article>
      HTML
    end

    def test_with_additional_attributes
      component = Message.new("With Attributes", class: "important", data: { value: "test" })

      assert_html_equal(<<~HTML, component.call { "Important content." })
        <article class="message important" data-value="test">
          <div class="message-header">
            <p>With Attributes</p>
          </div>
          <div class="message-body">
            Important content.
          </div>
        </article>
      HTML
    end
  end

  class CustomMessageTest < Minitest::Test
    include TagOutputAssertions

    class CustomMessage < Message
    end

    # monkey patch to override after_initialize
    class CustomMessage
      def after_initialize
        return unless @delete.nil?

        @delete = { data: { action: "deleteable#delete" } }
        @html_attributes = mix(@html_attributes, data: { controller: "deleteable" })
      end
    end

    def test_by_default_has_deleteable_controller
      component = CustomMessage.new("Custom")

      assert_html_equal(<<~HTML, component.call { "With stimulus controller." })
        <article class="message" data-controller="deleteable">
          <div class="message-header">
            <p>Custom</p>
            <button class="delete" aria-label="delete" data-action="deleteable#delete"></button>
          </div>
          <div class="message-body">
            With stimulus controller.
          </div>
        </article>
      HTML
    end

    def test_can_skip_delete_button
      component = CustomMessage.new("The Header", delete: false)

      assert_html_equal(<<~HTML, component.call { "The content." })
        <article class="message">
          <div class="message-header">
            <p>The Header</p>
          </div>
          <div class="message-body">
            The content.
          </div>
        </article>
      HTML
    end
  end
end
