# frozen_string_literal: true

module Playground
  module Sections
    class Breadcrumb < Phlex::HTML
      def view_template
        h2(class: "title is-4") { "Breadcrumb" }

        render BulmaPhlex::Breadcrumb.new do |bc|
          bc.item("Bulma", href: "/")
          bc.item("Components", href: "/components")
          bc.item("Breadcrumb")
        end

        h3(class: "subtitle is-5") { "Alignment" }
        render BulmaPhlex::Breadcrumb.new(align: "centered") do |bc|
          bc.item("Bulma", href: "/")
          bc.item("Components", href: "/components")
          bc.item("Breadcrumb")
        end

        render BulmaPhlex::Breadcrumb.new(align: "right") do |bc|
          bc.item("Bulma", href: "/")
          bc.item("Components", href: "/components")
          bc.item("Breadcrumb")
        end

        h3(class: "subtitle is-5") { "Separator Style" }
        render BulmaPhlex::Breadcrumb.new(separator: "arrow") do |bc|
          bc.item("Bulma", href: "/")
          bc.item("Components", href: "/components")
          bc.item("Breadcrumb")
        end

        render BulmaPhlex::Breadcrumb.new(separator: "bullet") do |bc|
          bc.item("Bulma", href: "/")
          bc.item("Components", href: "/components")
          bc.item("Breadcrumb")
        end

        render BulmaPhlex::Breadcrumb.new(separator: "dot") do |bc|
          bc.item("Bulma", href: "/")
          bc.item("Components", href: "/components")
          bc.item("Breadcrumb")
        end

        render BulmaPhlex::Breadcrumb.new(separator: "succeeds") do |bc|
          bc.item("Bulma", href: "/")
          bc.item("Components", href: "/components")
          bc.item("Breadcrumb")
        end

        h3(class: "subtitle is-5") { "Size" }
        render BulmaPhlex::Breadcrumb.new(size: "small") do |bc|
          bc.item("Bulma", href: "/")
          bc.item("Components", href: "/components")
          bc.item("Breadcrumb")
        end

        render BulmaPhlex::Breadcrumb.new(size: "medium") do |bc|
          bc.item("Bulma", href: "/")
          bc.item("Components", href: "/components")
          bc.item("Breadcrumb")
        end

        render BulmaPhlex::Breadcrumb.new(size: "large") do |bc|
          bc.item("Bulma", href: "/")
          bc.item("Components", href: "/components")
          bc.item("Breadcrumb")
        end

        h3(class: "subtitle is-5") { "With Icons" }
        render BulmaPhlex::Breadcrumb.new do |bc|
          bc.item("Home", href: "/", icon: "fas fa-home")
          bc.item("Components", href: "/components", icon: "fas fa-cubes")
          bc.item("Breadcrumb", icon: "fas fa-link")
        end
      end
    end
  end
end
