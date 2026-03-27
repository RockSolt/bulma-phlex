# frozen_string_literal: true

module Playground
  module Sections
    class FileUpload < Phlex::HTML
      def view_template
        h2(class: "title is-4") { "File Upload" }

        p(class: "content") do
          plain "Renders a styled Bulma file upload input. The block receives data attributes for "
          plain "Stimulus integration and must render the "
          code { "<input type=\"file\">" }
          plain " element."
        end

        h3(class: "subtitle is-5") { "Basic" }
        div(class: "mb-5") do
          render BulmaPhlex::FileUpload.new do |_attrs|
            input(type: "file", name: "resume")
          end
        end

        h3(class: "subtitle is-5") { "With File Name Display (name: true)" }
        div(class: "mb-5") do
          render BulmaPhlex::FileUpload.new(name: true) do |_attrs|
            input(type: "file", name: "avatar")
          end
        end

        h3(class: "subtitle is-5") { "Color (color: \"primary\")" }
        div(class: "mb-5") do
          render BulmaPhlex::FileUpload.new(color: "primary") do |_attrs|
            input(type: "file", name: "document")
          end
        end

        h3(class: "subtitle is-5") { "Size (size: \"large\")" }
        div(class: "mb-5") do
          render BulmaPhlex::FileUpload.new(size: "large") do |_attrs|
            input(type: "file", name: "attachment")
          end
        end

        h3(class: "subtitle is-5") { "Boxed (boxed: true)" }
        div(class: "mb-5") do
          render BulmaPhlex::FileUpload.new(boxed: true) do |_attrs|
            input(type: "file", name: "photo")
          end
        end

        h3(class: "subtitle is-5") { "Right Aligned (align: \"right\")" }
        div(class: "mb-5") do
          render BulmaPhlex::FileUpload.new(align: "right") do |_attrs|
            input(type: "file", name: "upload")
          end
        end

        h3(class: "subtitle is-5") { "Full Width (fullwidth: true)" }
        div(class: "mb-5") do
          render BulmaPhlex::FileUpload.new(fullwidth: true) do |_attrs|
            input(type: "file", name: "bulk_upload")
          end
        end

        h3(class: "subtitle is-5") { "Boxed + Color + Name" }
        div(class: "mb-5") do
          render BulmaPhlex::FileUpload.new(boxed: true, color: "info", name: true) do |_attrs|
            input(type: "file", name: "combined")
          end
        end
      end
    end
  end
end
