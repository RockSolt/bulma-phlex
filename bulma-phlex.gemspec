# frozen_string_literal: true

require_relative "lib/bulma_phlex/version"

Gem::Specification.new do |spec|
  spec.name = "bulma-phlex"
  spec.version = BulmaPhlex::VERSION
  spec.authors = ["Todd Kummer"]
  spec.email = ["todd@rockridgesolutions.com"]

  spec.homepage    = "https://github.com/RockSolt/bulma-phlex"
  spec.summary     = "Build Bulma components with Phlex."
  spec.description = "Add Bulma components including Card, Level, NavigationBar, Pagination, Table, and Tabs " \
                     "to your Phlex application."
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.4.0"

  spec.metadata["rubygems_mfa_required"] = "true"
  spec.metadata["homepage_uri"] = spec.homepage

  spec.files = Dir["lib/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "phlex", ">= 2.0.2"

  spec.add_development_dependency "actionpack"
  spec.add_development_dependency "minitest-difftastic"
end
