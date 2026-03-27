# BulmaPhlex Playground

A local development tool for visually testing BulmaPhlex components.

## Usage

From the project root:

```sh
bin/play
```

This renders all playground components to `playground/index.html`, which you can open directly in a browser.

## Adding a Component Section

1. Create a new file in `playground/sections/` (e.g. `card_section.rb`)
2. Define a class inside `Playground::Sections` that inherits from `Phlex::HTML`
3. Add the class to the `SECTIONS` array in `playground/page.rb`

### Example

```ruby
# playground/sections/card_section.rb
module Playground
  module Sections
    class Card < Phlex::HTML
      def view_template
        h2(class: "title is-4") { "Card" }

        h3(class: "label") { "Basic" }
        render BulmaPhlex::Card.new do |card|
          card.head("Card Title")
          card.content { "Some card content." }
        end
      end
    end
  end
end
```

## Notes

- `playground/index.html` is gitignored (generated output)
- The playground directory is not included in the packaged gem
- Components that require Stimulus (Tabs, Modal, Dropdown, NavigationBar) are shown in their static rendered state
