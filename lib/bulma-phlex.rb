# frozen_string_literal: true

require "bulma_phlex/version"
require "zeitwerk"
require "phlex"

loader = Zeitwerk::Loader.new
loader.tag = "bulma-phlex"
loader.push_dir(File.dirname(__FILE__))
loader.ignore(__FILE__)
loader.setup
