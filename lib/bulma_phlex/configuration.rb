# frozen_string_literal: true

module BulmaPhlex
  # Stores application-wide defaults for component-owned icons.
  class Configuration
    # Stores the icon classes used by components when no local override is supplied.
    class Icons
      attr_accessor :sort, :dropdown, :file_upload, :conditional

      def initialize
        @sort = {
          ascending: "fa-solid fa-sort-up",
          descending: "fa-solid fa-sort-down",
          inactive: "fa-solid fa-sort"
        }
        @dropdown = "fa-solid fa-angle-down"
        @file_upload = "fa-solid fa-upload"
        @conditional = "fa-solid fa-check"
      end
    end

    attr_reader :icons

    def initialize
      @icons = Icons.new
    end
  end
end
