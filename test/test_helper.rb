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
require "tag_output_assertions"
