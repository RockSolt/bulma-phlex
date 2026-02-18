# frozen_string_literal: true

require "test_helper"

module BulmaPhlex
  class HeroTest < Minitest::Test
    include TagOutputAssertions

    def test_renders_basic_hero
      component = BulmaPhlex::Hero.new(title: "Hero title", subtitle: "Hero subtitle")
      result = component.call

      assert_html_equal <<~HTML, result
        <section class="hero">
          <div class="hero-body">
            <p class="title">Hero title</p>
            <p class="subtitle">Hero subtitle</p>
          </div>
        </section>
      HTML
    end

    def test_with_color
      component = BulmaPhlex::Hero.new(title: "Hero Title", subtitle: "Hero subtitle", color: "primary")
      result = component.call

      assert_html_equal <<~HTML, result
        <section class="hero is-primary">
          <div class="hero-body">
            <p class="title">Hero Title</p>
            <p class="subtitle">Hero subtitle</p>
          </div>
        </section>
      HTML
    end

    def test_with_size
      component = BulmaPhlex::Hero.new(title: "Hero Title", subtitle: "Hero subtitle", size: "large")
      result = component.call

      assert_html_equal <<~HTML, result
        <section class="hero is-large">
          <div class="hero-body">
            <p class="title">Hero Title</p>
            <p class="subtitle">Hero subtitle</p>
          </div>
        </section>
      HTML
    end

    def test_with_body_passed_into_block
      component = BulmaPhlex::Hero.new(color: "info", size: "medium")
      result = component.call do
        "Custom hero body content"
      end

      assert_html_equal <<~HTML, result
        <section class="hero is-info is-medium">
          <div class="hero-body">
            Custom hero body content
          </div>
        </section>
      HTML
    end

    def test_with_head_body_and_foot
      component = BulmaPhlex::Hero.new(color: "danger")
      result = component.call do |hero|
        hero.head { "Hero head content" }
        hero.body { "Hero body content" }
        hero.foot { "Hero foot content" }
      end

      assert_html_equal <<~HTML, result
        <section class="hero is-danger">
          <div class="hero-head">
            Hero head content
          </div>
          <div class="hero-body">
            Hero body content
          </div>
          <div class="hero-foot">
            Hero foot content
          </div>
        </section>
      HTML
    end

    def test_with_additional_html_attributes
      component = BulmaPhlex::Hero.new(title: "Hero Title", subtitle: "Hero subtitle", color: "success", size: "small",
                                       class: "custom-class", data: { test: "value" })
      result = component.call

      assert_html_equal <<~HTML, result
        <section class="hero is-success is-small custom-class" data-test="value">
          <div class="hero-body">
            <p class="title">Hero Title</p>
            <p class="subtitle">Hero subtitle</p>
          </div>
        </section>
      HTML
    end
  end
end
