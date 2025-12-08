# frozen_string_literal: true

require "phlex"
require "zeitwerk"

loader = Zeitwerk::Loader.for_gem
loader.ignore("#{__dir__}/bulma-phlex.rb")
loader.setup # ready!

# A collection of Bulma components built with Phlex
#
# This module provides a set of components that implement the [Bulma CSS framework](https://bulma.io/)
# using the Phlex view component library. These components make it easy to build
# Bulma-styled applications with a Ruby-focused components.
module BulmaPhlex
  extend Phlex::Kit
end
