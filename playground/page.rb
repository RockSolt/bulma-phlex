# frozen_string_literal: true

module Playground
  # This generates the playground for each component. Components must have a Section class and be registered here.
  class Page < Phlex::HTML
    SECTIONS = [
      Sections::Button,
      Sections::Card,
      Sections::Columns,
      Sections::Dropdown,
      Sections::FileUpload,
      Sections::FormControl,
      Sections::FormField,
      Sections::Grid,
      Sections::Hero,
      Sections::Icon,
      Sections::Level,
      Sections::Message,
      # Sections::Modal,
      Sections::NavigationBar,
      Sections::Pagination,
      Sections::ProgressBar,
      Sections::Table,
      Sections::Tabs,
      Sections::Title,
      Sections::Notification,
      Sections::Tag
    ].freeze

    def view_template
      doctype
      html(lang: "en") do
        head do
          meta(charset: "UTF-8")
          meta(name: "viewport", content: "width=device-width, initial-scale=1")
          title { "BulmaPhlex Playground" }
          link(rel: "stylesheet", href: "https://cdn.jsdelivr.net/npm/bulma@1.0.2/css/bulma.min.css")
          link(rel: "stylesheet", href: "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css")
        end
        body do
          section(class: "section") do
            div(class: "container") do
              SECTIONS.each do |section_class|
                render section_class.new
                hr
              end
            end
          end
        end
      end
    end
  end
end
