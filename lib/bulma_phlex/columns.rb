# frozen_string_literal: true

module BulmaPhlex
  # Renders a responsive column layout using [Bulma's column system](https://bulma.io/documentation/columns/basics/).
  #
  # Supports options for **breakpoint**, **alignment** (centered, vertically centered), **layout**
  # (multiline, gap sizing), and responsive **gap** configuration per breakpoint.
  #
  class Columns < BulmaPhlex::Base
    # **Parameters**
    # - `minimum_breakpoint` — Sets the minimum breakpoint for the columns (e.g. `:tablet`, `:desktop`)
    # - `multiline` — If `true`, allows the columns to wrap onto multiple lines
    # - `gap` — An integer (0-8) to set the gap size, or a hash keyed by breakpoints for responsive gaps
    # - `centered` — If `true`, centers the columns
    # - `vcentered` — If `true`, vertically centers the columns
    # - `**html_attributes` — Additional HTML attributes for the columns container
    def self.new(minimum_breakpoint: nil,
                 multiline: false,
                 gap: nil,
                 centered: false,
                 vcentered: false,
                 **html_attributes)
      super
    end

    def initialize(minimum_breakpoint: nil,
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
