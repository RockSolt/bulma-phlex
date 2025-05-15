# frozen_string_literal: true

# Suppress method redefined warnings before requiring libraries
original_verbose = $VERBOSE
$VERBOSE = nil

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "bulma-phlex"
require "minitest/autorun"
require "nokogiri"
require "active_support/test_case"
require "action_view/test_case"

# Restore original warning level after libraries are loaded
$VERBOSE = original_verbose

module TagOutputAssertions
  include ActionView::TestCase::DomAssertions

  def assert_html_equal(expected, actual, message = nil)
    # First try the normal DOM comparison
    assert_dom_equal(expected, actual, message)
  rescue Minitest::Assertion => e
    puts "Caught Minitest::Assertion: #{e.class} - #{e.message}"

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
end
