# frozen_string_literal: true

require "test_helper"

class NoActiveSupportTest < Minitest::Test
  def test_no_present_usage
    failures = []
    forbidden = /present\?/
    Dir["./lib/**/*.rb"].each do |file|
      File.readlines(file).each_with_index do |line, index|
        failures << "#{file}:#{index + 1}\n  #{line.lstrip}" if forbidden.match?(line)
      end
    end

    assert failures.empty?, "Do not use `.present?`\n#{failures.join("\n")}"
  end
end
