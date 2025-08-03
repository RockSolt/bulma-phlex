# frozen_string_literal: true

require "bulma_phlex/rails/card_helper"
require "bulma_phlex/rails/table_helper"

module BulmaPhlex
  # # Railtie for BulmaPhlex
  #
  # This Railtie adds Rails-specific features to the BulmaPhlex library.
  class Railtie < ::Rails::Railtie
    initializer "bulma_phlex" do
      ActiveSupport.on_load(:action_view) do
        if defined?(Phlex::Rails)
          Components::Bulma::Card.include(BulmaPhlex::Rails::CardHelper) if defined?(Turbo)
          Components::Bulma::Table.include(BulmaPhlex::Rails::TableHelper)
        end
      end
    end
  end
end
