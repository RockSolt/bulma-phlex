# frozen_string_literal: true

require "test_helper"

module BulmaPhlex
  class TitleTest < Minitest::Test
    include TagOutputAssertions

    def test_title_renders_correctly
      component = Title.new("Hello World")
      expected_html = '<h1 class="title">Hello World</h1>'
      assert_html_equal expected_html, component.call
    end

    def test_title_with_different_size
      component = Title.new("Hello World", size: 2)
      expected_html = '<h1 class="title is-2">Hello World</h1>'
      assert_html_equal expected_html, component.call
    end

    def test_title_with_subtitle
      component = Title.new("Hello World", subtitle: "Subtitle here")
      expected_html = '<h1 class="title">Hello World</h1><h2 class="subtitle">Subtitle here</h2>'
      assert_html_equal expected_html, component.call
    end

    def test_with_size_on_title_but_not_on_subtitle
      component = Title.new("Hello World", size: 3, subtitle: "Subtitle here")
      expected_html = '<h1 class="title is-3">Hello World</h1><h2 class="subtitle is-5">Subtitle here</h2>'
      assert_html_equal expected_html, component.call
    end

    def test_with_size_on_both_title_and_subtitle
      component = Title.new("Hello World", size: 2, subtitle: "Subtitle here", subtitle_size: 6)
      expected_html = '<h1 class="title is-2">Hello World</h1><h2 class="subtitle is-6">Subtitle here</h2>'
      assert_html_equal expected_html, component.call
    end

    def test_with_spaced_option
      component = Title.new("Hello World", spaced: true, subtitle: "Nice to see you again")
      expected_html = '<h1 class="title is-spaced">Hello World</h1><h2 class="subtitle">Nice to see you again</h2>'
      assert_html_equal expected_html, component.call
    end
  end
end
