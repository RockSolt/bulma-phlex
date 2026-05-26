# frozen_string_literal: true

require "test_helper"

module BulmaPhlex
  class BreadcrumbTest < Minitest::Test
    include TagOutputAssertions

    def test_breadcrumb
      component = BulmaPhlex::Breadcrumb.new
      results = component.call do |bc|
        bc.item("Bulma", href: "/")
        bc.item("Components", href: "/components")
        bc.item("Breadcrumb")
      end

      assert_html_equal <<~HTML, results
        <nav class="breadcrumb" aria-label="breadcrumbs">
          <ul>
            <li><a href="/">Bulma</a></li>
            <li><a href="/components">Components</a></li>
            <li class="is-active"><a aria-current="page">Breadcrumb</a></li>
          </ul>
        </nav>
      HTML
    end

    def test_single_item_breadcrumb
      component = BulmaPhlex::Breadcrumb.new
      results = component.call do |bc|
        bc.item("Home", href: "/")
      end

      assert_html_equal <<~HTML, results
        <nav class="breadcrumb" aria-label="breadcrumbs">
          <ul>
            <li class="is-active"><a href="/" aria-current="page">Home</a></li>
          </ul>
        </nav>
      HTML
    end

    def test_align_centered
      component = BulmaPhlex::Breadcrumb.new(align: "centered")
      results = component.call do |bc|
        bc.item("Bulma", href: "/")
        bc.item("Components", href: "/components")
        bc.item("Breadcrumb")
      end

      assert_html_equal <<~HTML, results
        <nav class="breadcrumb is-centered" aria-label="breadcrumbs">
          <ul>
            <li><a href="/">Bulma</a></li>
            <li><a href="/components">Components</a></li>
            <li class="is-active"><a aria-current="page">Breadcrumb</a></li>
          </ul>
        </nav>
      HTML
    end

    def test_align_right
      component = BulmaPhlex::Breadcrumb.new(align: "right")
      results = component.call do |bc|
        bc.item("Bulma", href: "/")
        bc.item("Components", href: "/components")
        bc.item("Breadcrumb")
      end

      assert_html_includes results, 'class="breadcrumb is-right"'
    end

    def test_separator
      component = BulmaPhlex::Breadcrumb.new(separator: "arrow")
      results = component.call do |bc|
        bc.item("Bulma", href: "/")
        bc.item("Components", href: "/components")
        bc.item("Breadcrumb")
      end

      assert_html_equal <<~HTML, results
        <nav class="breadcrumb has-arrow-separator" aria-label="breadcrumbs">
          <ul>
            <li><a href="/">Bulma</a></li>
            <li><a href="/components">Components</a></li>
            <li class="is-active"><a aria-current="page">Breadcrumb</a></li>
          </ul>
        </nav>
      HTML
    end

    def test_bullet_separator
      component = BulmaPhlex::Breadcrumb.new(separator: "bullet")
      results = component.call do |bc|
        bc.item("Bulma", href: "/")
        bc.item("Components", href: "/components")
        bc.item("Breadcrumb")
      end

      assert_html_includes results, 'class="breadcrumb has-bullet-separator"'
    end

    def test_size_small
      component = BulmaPhlex::Breadcrumb.new(size: "small")
      results = component.call do |bc|
        bc.item("Bulma", href: "/")
        bc.item("Components", href: "/components")
        bc.item("Breadcrumb")
      end

      assert_html_equal <<~HTML, results
        <nav class="breadcrumb is-small" aria-label="breadcrumbs">
          <ul>
            <li><a href="/">Bulma</a></li>
            <li><a href="/components">Components</a></li>
            <li class="is-active"><a aria-current="page">Breadcrumb</a></li>
          </ul>
        </nav>
      HTML
    end

    def test_size_large
      component = BulmaPhlex::Breadcrumb.new(size: "large")
      results = component.call do |bc|
        bc.item("Bulma", href: "/")
        bc.item("Components", href: "/components")
        bc.item("Breadcrumb")
      end

      assert_html_includes results, 'class="breadcrumb is-large"'
    end

    def test_with_icons
      component = BulmaPhlex::Breadcrumb.new
      results = component.call do |bc|
        bc.item("Bulma", href: "/", icon: "fas fa-home")
        bc.item("Components", href: "/components", icon: "fas fa-puzzle-piece")
        bc.item("Breadcrumb", icon: "fas fa-thumbs-up")
      end

      assert_html_equal <<~HTML, results
        <nav class="breadcrumb" aria-label="breadcrumbs">
          <ul>
            <li>
              <a href="/">
                <span class="icon is-small">
                  <i class="fas fa-home" aria-hidden="true"></i>
                </span>
                <span>Bulma</span>
              </a>
            </li>
            <li>
              <a href="/components">
                <span class="icon is-small">
                  <i class="fas fa-puzzle-piece" aria-hidden="true"></i>
                </span>
                <span>Components</span>
              </a>
            </li>
            <li class="is-active">
              <a aria-current="page">
                <span class="icon is-small">
                  <i class="fas fa-thumbs-up" aria-hidden="true"></i>
                </span>
                <span>Breadcrumb</span>
              </a>
            </li>
          </ul>
        </nav>
      HTML
    end

    def test_additional_html_attributes
      component = BulmaPhlex::Breadcrumb.new(data: { test: "breadcrumb-component" })
      results = component.call do |bc|
        bc.item("Bulma", href: "/")
        bc.item("Components", href: "/components")
        bc.item("Breadcrumb")
      end

      assert_html_includes results, 'data-test="breadcrumb-component"'
    end
  end
end
