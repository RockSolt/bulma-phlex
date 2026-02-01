# frozen_string_literal: true

module BulmaPhlex
  # # Columns Component
  #
  # The Columns component creates a responsive column layout using Bulma's column system.
  #
  # ## Keyword Arguments
  #
  # - `minimum_breakpoint`: (Symbol, optional) Sets the minimum breakpoint for the columns; default is `:tablet`.
  # - `multiline`: (Boolean, optional) If true, allows the columns to wrap onto multiple lines.
  # - `gap`: (optional) Use an integer (0-8) to set the gap size between columns; use a hash keyed by breakpoints
  #   to set responsive gap sizes.
  # - `centered`: (Boolean, optional) If true, centers the columns.
  # - `vcentered`: (Boolean, optional) If true, vertically centers the columns.
  class Columns < BulmaPhlex::Base
    def initialize(minimum_breakpoint: nil, # rubocop:disable Metrics/ParameterLists
                   multiline: false,
                   gap: nil,
                   centered: false,
                   vcentered: false,
                   **html_attributes)
      @minimum_breakpoint = minimum_breakpoint
      @multiline = multiline
      @gap = gap
      @centered = centered
      @vcentered = vcentered
      @html_attributes = html_attributes
    end

    def view_template(&)
      div(**mix({ class: columns_classes }, @html_attributes), &)
    end

    private

    def columns_classes
      classes = ["columns"]
      classes << "is-#{@minimum_breakpoint}" if @minimum_breakpoint
      classes << "is-multiline" if @multiline
      classes << "is-centered" if @centered
      classes << "is-vcentered" if @vcentered
      gap_classes(classes) if @gap
      classes.join(" ")
    end

    def gap_classes(classes)
      if @gap.is_a?(Integer)
        classes << "is-#{@gap}"
      elsif @gap.is_a?(Hash)
        @gap.each do |breakpoint, size|
          classes << "is-#{size}-#{breakpoint}"
        end
      end
    end
  end
end
