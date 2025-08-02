# frozen_string_literal: true

module BulmaPhlex
  module Rails
    # # Table Helper
    #
    # This module provides method `amount_column` to create an amount column in a table.
    module TableHelper
      extend ActiveSupport::Concern

      included do
        include Phlex::Rails::Helpers::NumberToCurrency
      end

      def amount_column(header, currency: {}, **html_attributes, &content)
        html_attributes[:class] = [html_attributes[:class], "has-text-right"].compact.join(" ")

        column(header, **html_attributes) do |row|
          number_to_currency(content.call(row), **currency)
        end
      end
    end
  end
end
