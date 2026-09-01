# frozen_string_literal: true

module BulmaPhlex
  # Stores application-wide defaults for component-owned icons.
  class Configuration
    # Stores the icon classes used by components when no local override is supplied.
    class Icons
      attr_accessor :sort, :dropdown, :file_upload, :conditional

      def initialize
        @sort = {
          ascending: "fas fa-sort-up",
          descending: "fas fa-sort-down",
          inactive: "fas fa-sort"
        }
        @dropdown = "fas fa-angle-down"
        @file_upload = "fas fa-upload"
        @conditional = "fas fa-check"
      end
    end

    attr_reader :icons

    def initialize
      @icons = Icons.new
    end
  end
end
