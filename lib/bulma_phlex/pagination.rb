# frozen_string_literal: true

module BulmaPhlex
  # Renders the [Bulma pagination](https://bulma.io/documentation/components/pagination/) component.
  #
  # Accepts a pager object and a path builder callable. Automatically renders previous/next links,
  # numbered page links with ellipses for skipped ranges, and a summary of items being displayed.
  # Only renders when there is more than one page of results.
  #
  # ## Example
  #
  #     # In a controller action:
  #     @products = Product.page(params[:page]).per(20)
  #
  #     # In the view:
  #     render BulmaPhlex::Pagination.new(@products, ->(page) { products_path(page: page) })
  #
  class Pagination < BulmaPhlex::Base
    attr_reader :pager, :path_builder

    # **Parameters**
    # - `pager` — A page object responding to `current_page`, `total_pages`, `per_page`,
    #   `total_count`, `previous_page`, and `next_page`
    # - `path_builder` — A callable that takes a page number and returns a URL string
    # - `**html_attributes` — Additional HTML attributes for the pagination container
    def self.new(pager, path_builder, **html_attributes)
      super
    end

    def initialize(pager, path_builder, **html_attributes)
      @pager = pager
      @path_builder = path_builder
      @html_attributes = html_attributes
    end

    def view_template
      return unless pager.total_pages > 1

      div(**mix({ class: "pagination-container" }, @html_attributes)) do
        nav(class: "pagination", role: "navigation", aria_label: "pagination") do
          # Previous page link
          if pager.previous_page
            a(class: "pagination-previous", href: page_url(pager.previous_page)) { "Previous" }
          else
            a(class: "pagination-previous", disabled: true) { "Previous" }
          end

          # Next page link
          if pager.next_page
            a(class: "pagination-next", href: page_url(pager.next_page)) { "Next" }
          else
            a(class: "pagination-next", disabled: true) { "Next" }
          end

          # Page number links
          ul(class: "pagination-list") do
            # First page and ellipsis if needed
            if pager.current_page > 3
              render_page_item(1)
              render_ellipsis if pager.current_page > 4
            end

            # Pages around current page
            page_window.each do |page_number|
              render_page_item(page_number)
            end

            # Ellipsis and last page if needed
            if pager.current_page < pager.total_pages - 2
              render_ellipsis if pager.current_page < pager.total_pages - 3
              render_page_item(pager.total_pages)
            end
          end
        end

        div(class: "has-text-centered mt-2 is-size-7") do
          start_item = ((pager.current_page - 1) * pager.per_page) + 1
          end_item = [start_item + pager.per_page - 1, pager.total_count].min

          plain "Showing #{start_item}-#{end_item} of #{pager.total_count} items"
        end
      end
    end

    private

    def render_page_item(page_number)
      li do
        if page_number == pager.current_page
          a(class: "pagination-link is-current",
            aria_label: "Page #{page_number}",
            aria_current: "page") { page_number.to_s }
        else
          a(class: "pagination-link",
            href: page_url(page_number),
            aria_label: "Go to page #{page_number}") { page_number.to_s }
        end
      end
    end

    def render_ellipsis
      li { span(class: "pagination-ellipsis") { "…" } }
    end

    def page_window
      start_page = [pager.current_page - 2, 1].max
      end_page = [pager.current_page + 2, pager.total_pages].min
      (start_page..end_page).to_a
    end

    def page_url(page_number)
      @path_builder.call(page_number)
    end
  end
end
