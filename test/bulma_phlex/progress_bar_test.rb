# frozen_string_literal: true

require "test_helper"

module BulmaPhlex
  class ProgressBarTest < Minitest::Test
    include TagOutputAssertions

    def test_progress_bar
      component = BulmaPhlex::ProgressBar.new

      result = component.call { "45%" }

      assert_html_equal <<~HTML, result
        <progress class="progress">45%</progress>
      HTML
    end

    def test_with_size
      component = BulmaPhlex::ProgressBar.new(size: :large)

      result = component.call { "45%" }

      assert_html_equal <<~HTML, result
        <progress class="progress is-large">45%</progress>
      HTML
    end

    def test_with_color
      component = BulmaPhlex::ProgressBar.new(color: :primary)

      result = component.call { "45%" }

      assert_html_equal <<~HTML, result
        <progress class="progress is-primary">45%</progress>
      HTML
    end

    def test_with_html_attributes_for_value_and_max
      component = BulmaPhlex::ProgressBar.new(value: 45, max: 100)

      result = component.call { "45%" }

      assert_html_equal <<~HTML, result
        <progress class="progress" value="45" max="100">45%</progress>
      HTML
    end

    def test_with_all_options
      component = BulmaPhlex::ProgressBar.new(color: :primary, size: :large, value: 45, max: 100)

      result = component.call { "45%" }

      assert_html_equal <<~HTML, result
        <progress class="progress is-primary is-large" value="45" max="100">45%</progress>
      HTML
    end
  end
end
