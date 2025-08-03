# frozen_string_literal: true

require "bulma_phlex/version"
require "phlex"

require "components/bulma"
require "components/bulma/base"
require "components/bulma/card"
require "components/bulma/dropdown"
require "components/bulma/level"
require "components/bulma/navigation_bar_dropdown"
require "components/bulma/navigation_bar"
require "components/bulma/pagination"
require "components/bulma/table"
require "components/bulma/tabs"
require "components/bulma/tab_components/content"
require "components/bulma/tab_components/tab"

require "bulma_phlex/railtie" if defined?(Rails::Railtie)
