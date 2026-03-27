# frozen_string_literal: true

module Playground
  module Sections
    class Modal < Phlex::HTML
      def view_template
        h2(class: "title is-4") { "Modal" }

        h3(class: "label") { "Basic Modal (active)" }
        div(class: "mb-5") do
          # Render a basic modal. In the playground the modal is shown in its active state
          # because JavaScript controllers are not wired up here.
          render BulmaPhlex::Modal.new(class: "is-active") do
            div(class: "box") do
              h4(class: "title is-5") { plain "Simple Modal" }
              p { plain "This is a modal body. Use modals for lightbox-style dialogs and confirmations." }
            end
          end
        end

        h3(class: "label") { "Modal Card (header / body / footer)" }
        div(class: "mb-5") do
          # Many UIs use the 'modal-card' variant which provides a standardized header/body/footer layout.
          render BulmaPhlex::Modal.new(class: "is-active") do
            div(class: "modal-card") do
              header(class: "modal-card-head") do
                p(class: "modal-card-title") { plain "Confirm Action" }
                button(class: "delete", aria_label: "close")
              end

              section(class: "modal-card-body") do
                p do
                  plain "Are you sure you want to perform this irreversible action? This is a longer description " \
                        "so it sits comfortably inside the modal body."
                end
                ul do
                  li { plain "It will affect several records." }
                  li { plain "It cannot be undone." }
                end
              end

              footer(class: "modal-card-foot") do
                render BulmaPhlex::Button.new(color: "danger") { "Confirm" }
                render BulmaPhlex::Button.new(outlined: true, class: "ml-2") { "Cancel" }
              end
            end
          end
        end

        h3(class: "label") { "Form in Modal" }
        div(class: "mb-5") do
          render BulmaPhlex::Modal.new(class: "is-active") do
            div(class: "box") do
              h4(class: "title is-5") { plain "Subscribe" }
              form do
                div(class: "field") do
                  label(class: "label") { plain "Email" }
                  div(class: "control") do
                    input(class: "input", type: "email", placeholder: "you@example.com")
                  end
                end

                div(class: "field is-grouped") do
                  div(class: "control") do
                    render BulmaPhlex::Button.new(color: "primary") { "Subscribe" }
                  end
                  div(class: "control") do
                    render BulmaPhlex::Button.new(outlined: true) { "Cancel" }
                  end
                end
              end
            end
          end
        end

        h3(class: "label") { "Large Content / Scrolling" }
        div(class: "mb-5") do
          render BulmaPhlex::Modal.new(class: "is-active") do
            div(class: "box", style: "max-height: 300px; overflow:auto;") do
              h4(class: "title is-5") { plain "Scrollable Content" }
              1.upto(12) do |i|
                p { plain "Paragraph #{i}: Lorem ipsum dolor sit amet, consectetur adipiscing elit." }
              end
            end
          end
        end

        h3(class: "label") { "Static Demo: close button and background" }
        div(class: "mb-5") do
          # Demonstrate the close button and background markup that the modal component will render.
          render BulmaPhlex::Modal.new(class: "is-active") do
            div(class: "box") do
              p do
                plain "Clicking the background or the close button would normally dismiss the modal when JS is enabled."
              end
              p(class: "is-size-7 has-text-grey") do
                plain "Playground shows the modal in a static active state for inspection."
              end
            end
          end
        end
      end
    end
  end
end
