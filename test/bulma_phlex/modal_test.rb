# frozen_string_literal: true

require "test_helper"

module BulmaPhlex
  class ModalTest < Minitest::Test
    include TagOutputAssertions

    def test_renders_basic_modal
      component = BulmaPhlex::Modal.new
      result = component.call do
        "Modal content goes here"
      end

      assert_html_equal <<~HTML, result
        <div class="modal" data-controller="bulma-phlex--modal">
          <div class="modal-background" data-action="click->bulma-phlex--modal#close"></div>
          <div class="modal-content">
            Modal content goes here
          </div>
          <button class="modal-close is-large" aria-label="close" data-action="bulma-phlex--modal#close"></button>
        </div>
      HTML
    end

    def test_renders_modal_with_additional_classes
      component = BulmaPhlex::Modal.new(class: "is-active", data: { test: "value" })
      result = component.call do
        "Active modal content"
      end

      assert_html_equal <<~HTML, result
        <div class="modal is-active" data-controller="bulma-phlex--modal" data-test="value">
          <div class="modal-background" data-action="click->bulma-phlex--modal#close"></div>
          <div class="modal-content">
            Active modal content
          </div>
          <button class="modal-close is-large" aria-label="close" data-action="bulma-phlex--modal#close"></button>
        </div>
      HTML
    end
  end
end
