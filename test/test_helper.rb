# frozen_string_literal: true

# Suppress only Phlex-related 'method redefined' warnings
module Warning
  def self.warn(msg)
    return if msg =~ %r{gems/phlex}i

    super
  end
end

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "bulma-phlex"
require "minitest/autorun"
require "nokogiri"
require "active_support/test_case"
require "action_view/test_case"

module TagOutputAssertions
  include ActionView::TestCase::DomAssertions

  def assert_html_equal(expected, actual, message = nil)
    # First try the normal DOM comparison
    assert_dom_equal(expected, actual, message)
  rescue Minitest::Assertion
    # If the DOM comparison fails, format the HTML for better readability
    expected_formatted = format_html(expected)
    actual_formatted = format_html(actual)

    # Now do a string comparison which will automatically generate a nice diff
    assert_equal expected_formatted, actual_formatted, message
  end

  def assert_html_includes(html, substring, msg = nil)
    return assert(true) if html.include?(substring)

    formatted_html = format_html(html)
    formatted_substring = format_html(substring)

    return assert(true) if squash_html_whitespace(formatted_html).include?(squash_html_whitespace(formatted_substring))

    msg = message(msg) do
      "Expected HTML to include substring.\n\n" \
        "HTML:\n#{formatted_html}\n\n" \
        "Expected to include:\n#{formatted_substring}\n\n" \
    end

    assert false, msg
  end

  # Helper method to format HTML with proper indentation
  def format_html(html)
    # Parse and re-serialize the HTML with indentation
    Nokogiri::HTML.fragment(html).to_xhtml(indent: 2)
  rescue StandardError => e
    puts "Error formatting HTML: #{e.message}"
    html
  end

  def squash_html_whitespace(str)
    # Replace whitespace between tags as well as leading/trailing whitespace
    str.gsub(/>\s+</, "><").strip
  end
end
