# frozen_string_literal: true

require "test_helper"

module BulmaPhlex
  class MediaObjectTest < Minitest::Test
    include TagOutputAssertions

    def test_renders_left_content
      component = BulmaPhlex::MediaObject.new

      result = component.call do |mo|
        mo.left do
          mo.p(class: "image is-64x64") do
            mo.img(src: "https://bulma.io/assets/images/placeholders/128x128.png")
          end
        end
      end

      assert_html_equal <<~HTML, result
        <article class="media">
          <figure class="media-left">
            <p class="image is-64x64">
              <img src="https://bulma.io/assets/images/placeholders/128x128.png" />
            </p>
          </figure>
        </article>
      HTML
    end

    def test_renders_image_in_left_content
      component = BulmaPhlex::MediaObject.new

      result = component.call do |mo|
        mo.image(src: "https://bulma.io/assets/images/placeholders/128x128.png",
                 alt: "Placeholder image",
                 size: 64,
                 rounded: true)
      end

      assert_html_equal <<~HTML, result
        <article class="media">
          <figure class="media-left">
            <p class="image is-64x64">
              <img src="https://bulma.io/assets/images/placeholders/128x128.png" alt="Placeholder image" class="is-rounded" />
            </p>
          </figure>
        </article>
      HTML
    end

    def test_renders_content
      component = BulmaPhlex::MediaObject.new

      result = component.call do |mo|
        mo.content do
          mo.div(class: "content") do
            mo.p do
              mo.strong { "John Smith" }
              mo.small { "@johnsmith" }
              mo.small { "31m" }
              mo.br
              mo.plain <<~CONTENT
                Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin ornare magna eros, eu pellentesque tortor vestibulum ut. Maecenas non massa sem. Etiam finibus odio quis feugiat facilisis.
              CONTENT
            end
          end
        end
      end

      assert_html_equal <<~HTML, result
        <article class="media">
          <div class="media-content">
            <div class="content">
              <p>
                <strong>John Smith</strong>
                <small>@johnsmith</small>
                <small>31m</small>
                <br />
                Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin ornare
                magna eros, eu pellentesque tortor vestibulum ut. Maecenas non massa
                sem. Etiam finibus odio quis feugiat facilisis.
              </p>
            </div>
          </div>
        </article>
      HTML
    end

    def test_renders_right_content
      component = BulmaPhlex::MediaObject.new

      result = component.call do |mo|
        mo.right do
          mo.button(class: "delete")
        end
      end

      assert_html_equal <<~HTML, result
        <article class="media">
          <div class="media-right">
            <button class="delete"></button>
          </div>
        </article>
      HTML
    end

    def test_renders_with_left_and_content_and_right
      component = BulmaPhlex::MediaObject.new

      result = component.call do |mo|
        mo.left { "Left Content" }
        mo.content { "Main Content" }
        mo.right { "Right Content" }
      end

      assert_html_equal <<~HTML, result
        <article class="media">
          <figure class="media-left">
            Left Content
          </figure>
          <div class="media-content">
            Main Content
          </div>
          <div class="media-right">
            Right Content
          </div>
        </article>
      HTML
    end

    def test_with_inputs # rubocop:disable Metrics/AbcSize
      component = BulmaPhlex::MediaObject.new

      result = component.call do |mo| # rubocop:disable Metrics/BlockLength
        mo.left do
          mo.p(class: "image is-64x64") do
            mo.img(src: "https://bulma.io/assets/images/placeholders/128x128.png")
          end
        end

        mo.content do
          mo.div(class: "field") do
            mo.p(class: "control") do
              mo.textarea(class: "textarea", placeholder: "Add a comment...")
            end
          end
          mo.nav(class: "level") do
            mo.div(class: "level-left") do
              mo.div(class: "level-item") do
                mo.a(class: "button is-info") { "Submit" }
              end
            end
            mo.div(class: "level-right") do
              mo.div(class: "level-item") do
                mo.label(class: "checkbox") do
                  mo.input(type: "checkbox")
                  mo.plain " Press enter to submit"
                end
              end
            end
          end
        end
      end

      assert_html_equal <<~HTML, result
        <article class="media">
          <figure class="media-left">
            <p class="image is-64x64">
              <img src="https://bulma.io/assets/images/placeholders/128x128.png" />
            </p>
          </figure>
          <div class="media-content">
            <div class="field">
              <p class="control">
                <textarea class="textarea" placeholder="Add a comment..."></textarea>
              </p>
            </div>
            <nav class="level">
              <div class="level-left">
                <div class="level-item">
                  <a class="button is-info">Submit</a>
                </div>
              </div>
              <div class="level-right">
                <div class="level-item">
                  <label class="checkbox">
                    <input type="checkbox" /> Press enter to submit
                  </label>
                </div>
              </div>
            </nav>
          </div>
        </article>
      HTML
    end

    def test_with_html_attributes
      component = BulmaPhlex::MediaObject.new(id: "media-object", class: "custom-class")

      result = component.call do |media|
        media.content { "Main Content" }
      end

      assert_html_equal <<~HTML, result
        <article id="media-object" class="media custom-class">
          <div class="media-content">
            Main Content
          </div>
        </article>
      HTML
    end

    def test_with_additional_html_attributes_on_left_content
      component = BulmaPhlex::MediaObject.new

      result = component.call do |media|
        media.left(id: "left-content", class: "custom-left-class") { "Left Content" }
      end

      assert_html_equal <<~HTML, result
        <article class="media">
          <figure id="left-content" class="media-left custom-left-class">
            Left Content
          </figure>
        </article>
      HTML
    end

    def test_with_additional_html_attributes_on_content
      component = BulmaPhlex::MediaObject.new

      result = component.call do |media|
        media.content(id: "content", class: "custom-content-class") { "Main Content" }
      end

      assert_html_equal <<~HTML, result
        <article class="media">
          <div id="content" class="media-content custom-content-class">
            Main Content
          </div>
        </article>
      HTML
    end

    def test_with_additional_html_attributes_on_right_content
      component = BulmaPhlex::MediaObject.new

      result = component.call do |media|
        media.right(id: "right-content", class: "custom-right-class") { "Right Content" }
      end

      assert_html_equal <<~HTML, result
        <article class="media">
          <div id="right-content" class="media-right custom-right-class">
            Right Content
          </div>
        </article>
      HTML
    end
  end
end
