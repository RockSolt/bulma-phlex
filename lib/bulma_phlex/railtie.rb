# frozen_string_literal: true

module BulmaPhlex
  # # Railtie for BulmaPhlex
  #
  # This Railtie adds Rails-specific features to the BulmaPhlex library.
  class Railtie < ::Rails::Railtie
    initializer "bulma_phlex" do
      ActiveSupport.on_load(:action_view) do
        Components::Bulma::Card.include(BulmaPhlex::Rails::CardHelper) if defined?(Phlex::Rails) && defined?(Turbo)
      end
    end
  end
end
