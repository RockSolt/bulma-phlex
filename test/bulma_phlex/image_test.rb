# frozen_string_literal: true

require "test_helper"

module BulmaPhlex
  class ImageTest < Minitest::Test
    include TagOutputAssertions

    def test_renders_image
      result = BulmaPhlex::Image.new(src: "image.jpg").call

      assert_html_equal <<~HTML, result
        <figure class="image">
          <img src="image.jpg"/>
        </figure>
      HTML
    end

    def test_renders_image_with_alt_text
      result = BulmaPhlex::Image.new(src: "image.jpg", alt: "An image").call

      assert_html_equal <<~HTML, result
        <figure class="image">
          <img src="image.jpg" alt="An image"/>
        </figure>
      HTML
    end

    def test_with_rounded
      result = BulmaPhlex::Image.new(src: "image.jpg", rounded: true).call

      assert_html_equal <<~HTML, result
        <figure class="image">
          <img src="image.jpg" class="is-rounded"/>
        </figure>
      HTML
    end

    def test_with_size
      result = BulmaPhlex::Image.new(src: "image.jpg", size: 64).call

      assert_html_equal <<~HTML, result
        <figure class="image is-64x64">
          <img src="image.jpg"/>
        </figure>
      HTML
    end

    def test_renders_image_with_ratio
      result = BulmaPhlex::Image.new(src: "image.jpg", ratio: "16by9").call

      assert_html_equal <<~HTML, result
        <figure class="image is-16by9">
          <img src="image.jpg"/>
        </figure>
      HTML
    end

    def test_with_additional_img_attributes
      result = BulmaPhlex::Image.new(src: "image.jpg",
                                     img_attributes: { class: "custom-img-class",
                                                       id: "image-id" }).call

      assert_html_equal <<~HTML, result
        <figure class="image">
          <img src="image.jpg" class="custom-img-class" id="image-id"/>
        </figure>
      HTML
    end

    def test_with_additional_html_attributes
      result = BulmaPhlex::Image.new(src: "image.jpg", class: "custom-class", id: "image-id").call

      assert_html_equal <<~HTML, result
        <figure class="image custom-class" id="image-id">
          <img src="image.jpg"/>
        </figure>
      HTML
    end
  end
end
