[![Gem Version](https://badge.fury.io/rb/bulma-phlex.svg)](https://badge.fury.io/rb/bulma-phlex)
[![Tests](https://github.com/RockSolt/bulma-phlex/actions/workflows/test.yml/badge.svg)](https://github.com/RockSolt/bulma-phlex/actions/workflows/test.yml)
[![RuboCop](https://github.com/RockSolt/bulma-phlex/actions/workflows/rubocop.yml/badge.svg)](https://github.com/RockSolt/bulma-phlex/actions/workflows/rubocop.yml)

# Bulma Components Built with Phlex

This gem provides a set of ready-to-use [Phlex](https://github.com/phlex-ruby/phlex) components for common [Bulma](https://bulma.io/) components and elements, making it easy to build beautiful, responsive interfaces with a clean, Ruby-focused API.

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
  - [Button](#button)
  - [Card](#card)
  - [Columns](#columns)
  - [Dropdown](#dropdown)
  - [File Upload](#file-upload)
  - [Form Field](#form-field)
  - [Grid](#grid)
  - [Hero](#hero)
  - [Icon](#icon)
  - [Level](#level)
  - [Message](#message)
  - [Modal](#modal)
  - [NavigationBar](#navigationbar)
  - [Notification](#notification)
  - [Pagination](#pagination)
  - [Progress Bar](#progress-bar)
  - [Table](#table)
  - [Tabs](#tabs)
  - [Tag](#tag)
  - [Title and Subtitle](#title-and-subtitle)
- [Development](#development)
- [Contributing](#contributing)
- [License](#license)
- [Credits](#credits)

## Installation

Add this line to your application's Gemfile:

```ruby
gem "bulma-phlex"
```

And then execute:

```bash
bundle install
```

Or install it yourself as:

```bash
gem install bulma-phlex
```

### Dependencies

This gem requires:

- Ruby 3.2.10 or higher
- Phlex 2.4.1 or higher
- Bulma CSS (which you'll need to include in your application)

### Required Setup

1. Include Bulma CSS in your application. You can add it via npm/yarn, CDN, or the [bulma-rails](https://github.com/joshuajansen/bulma-rails) gem.

2. Require the gem in your code:

```ruby
require "bulma-phlex"
```


## Usage

Use the Phlex components in your Rails views or any Ruby application that supports Phlex components.

### Button

Renders a [Bulma button](https://bulma.io/documentation/elements/button/) element with support for color, size, style modifiers, and left/right icons.

The component generates a `<button>` by default. Pass an `href:` attribute to generate an `<a>` element instead. Pass `input: "submit"` (or `"button"` or `"reset"`) to generate an `<input>` element.

```ruby
BulmaPhlex::Button("Like", color: "primary", size: "large", icon: "fas fa-thumbs-up")
BulmaPhlex::Button(href: "/profile") { "View Profile" }
BulmaPhlex::Button(input: "submit", color: "success")
```

The button label can be passed in as a string or in a block.

### Card

Renders a [Bulma card](https://bulma.io/documentation/components/card/) with an optional header, content area, and footer links. Each section is populated via builder methods on the yielded component.

```ruby
render BulmaPhlex::Card.new do |card|
  card.head("Card Title")
  card.content do
    "This is some card content"
  end
  card.footer_link("View", "/view", target: "_blank")
  card.footer_link("Edit", "/edit", icon: "fas fa-edit")
end
```

Use method `footer_item` for full control of the footer items. Class `footer-item` must be on the outer element 
of the block.


### Columns

Renders the [Bulma columns](https://bulma.io/documentation/columns/basics/) wrapper `div` with the `columns` class and handles all layout options. Each column inside the block is responsible for its own `column` class and sizing.

```ruby
render BulmaPhlex::Columns.new(gap: 4, multiline: true) do
  div(class: "column is-one-third") { "Column 1" }
  div(class: "column is-one-third") { "Column 2" }
  div(class: "column is-one-third") { "Column 3" }
end
```

The `gap:` option accepts either an integer (0–8) or a hash keyed by breakpoint for responsive gap sizes.


### Dropdown

Renders a [Bulma dropdown](https://bulma.io/documentation/components/dropdown/) menu. Supports click-to-toggle (default, via a Stimulus controller) and hoverable (no JavaScript) modes.

```ruby
render BulmaPhlex::Dropdown.new("Next Actions...") do |dropdown|
  dropdown.link "View Profile", "/profile"
  dropdown.link "Go to Settings", "/settings"
  dropdown.divider
  dropdown.item("This is just a text item")
  dropdown.item { div(class: "has-text-weight-bold") { "Bold item" } }
end
```

Set `click: false` to use hover mode instead of the Stimulus controller.


### File Upload

Renders a styled [Bulma file upload](https://bulma.io/documentation/form/file/) input. The component generates the container and structural elements, then yields for the `<input>` element itself.

```ruby
render BulmaPhlex::FileUpload.new(color: "primary") do |data_attributes|
  input(type: "file", class: "file-input", data: data_attributes)
end
```

Set `name: true` to include a file name display element. When enabled, Stimulus data attributes are wired up automatically. The controller is not included in this gem; an [example implementation](https://github.com/RockSolt/bulma-phlex-rails/blob/main/app/javascript/controllers/bulma_phlex/file_input_display_controller.js) is available in the `bulma-phlex-rails` gem.


### Form Field

Renders a [Bulma form field](https://bulma.io/documentation/form/general/#form-field) grouping a label, control, and optional help text. Set the label via the `label` method (string or block) and the input via the `control` method.

```ruby
render BulmaPhlex::FormField.new(help: "We'll never share your email.") do |field|
  field.label("Email Address", for: "user_email_address")
  field.control { input(name: "user[email_address]", type: "email") }
end
```

The `column:` and `grid:` options integrate the field into Bulma's column and grid layout systems. Both accept `true`, a size string, or a breakpoint hash.


### Grid

Renders a [Bulma smart grid](https://bulma.io/documentation/grid/smart-grid/) layout. Supports fixed column counts, auto-count, minimum column width, and independent gap control.

```ruby
render BulmaPhlex::Grid.new(minimum_column_width: 16) do
  @tiles.each do |tile|
    div(class: "cell") { render tile }
  end
end
```


### Hero

Renders a [Bulma hero](https://bulma.io/documentation/layout/hero/) section with support for color and size options.

Content can be provided three ways: as `title:` and `subtitle:` keyword arguments, as a plain block for the body, or by calling `head`, `body`, and `foot` on the yielded component for full control over each section.

```ruby
render BulmaPhlex::Hero.new(title: "Welcome", subtitle: "Glad you're here!", color: "primary")

render BulmaPhlex::Hero.new(color: "info", size: "large") do |hero|
  hero.head { "header content" }
  hero.body { "body content" }
  hero.foot { "footer content" }
end
```


### Icon

Renders a [Bulma icon](https://bulma.io/documentation/elements/icon/) element. Supports color, size, optional text alongside the icon, and left/right positioning for use inside form controls.

```ruby
render BulmaPhlex::Icon.new("fas fa-user")
render BulmaPhlex::Icon.new("fas fa-home", size: :large, color: :primary, text_right: "Home")
```


### Level

Renders the [Bulma level](https://bulma.io/documentation/layout/level/) horizontal layout component. Place items in the left section, right section, or centered via the `left`, `right`, and `item` builder methods. Each can be called multiple times.

```ruby
render BulmaPhlex::Level.new do |level|
  level.left { button(class: "button") { "Back" } }
  level.right { button(class: "button is-primary") { "Save" } }
end
```


### Message

Renders a [Bulma message](https://bulma.io/documentation/components/message/) component with a header, optional delete button, and body.

```ruby
render BulmaPhlex::Message.new("Hello World", color: "info", delete: true) do
  "Look, it's a deletable message box!"
end
```


### Modal

Renders a [Bulma modal](https://bulma.io/documentation/components/modal/) dialog overlay with a background, content area, and close button. Content is provided via a block.

```ruby
render BulmaPhlex::Modal.new do
  div(class: "box") do
    h1(class: "title") { "Modal Title" }
    p { "This is the modal content." }
  end
end
```

The modal is shown by adding the `is-active` class to the container — nothing in the component does this automatically. The default Stimulus controller (`bulma-phlex--modal`) handles open/close behavior. Pass a custom `data_attributes_builder:` to integrate with a different JavaScript setup.


### NavigationBar

Renders a [Bulma navbar](https://bulma.io/documentation/components/navbar/) with support for branding, left/right nav links, and dropdown menus. Collapses automatically on mobile via the `bulma-phlex--navigation-bar` Stimulus controller (provided by the `bulma-phlex-rails` gem).

```ruby
render BulmaPhlex::NavigationBar.new(color: "primary") do |navbar|
  navbar.brand { a(href: "/", class: "navbar-item") { "My App" } }

  navbar.left do
    a(href: "/", class: "navbar-item") { "Home" }
    a(href: "/products", class: "navbar-item") { "Products" }
  end

  navbar.right do
    a(href: "/about", class: "navbar-item") { "About" }
  end
end
```

> [!NOTE]
> Setting `container: true` (or a constraint string like `"is-max-desktop"`) wraps the navbar content in a Bulma container for fixed-width layout. The navbar's background color still spans the full viewport width.


### Notification

Renders a [Bulma notification](https://bulma.io/documentation/elements/notification/) alert box with support for color and mode options.

```ruby
render BulmaPhlex::Notification.new(color: "info", delete: true) do
  "This is an informational notification."
end
```

The `delete:` option adds a dismiss button. It accepts `true` or a hash of HTML attributes for the button — useful for hooking into a Stimulus controller.

```ruby
render BulmaPhlex::Notification.new(color: "warning", delete: { data: { action: "bulma-phlex--notification#close" } }) do
  "This notification has a wired-up close button."
end
```


### Pagination

Renders the [Bulma pagination](https://bulma.io/documentation/components/pagination/) component with previous/next links, numbered page links, ellipses for skipped ranges, and an item count summary. Only renders when there is more than one page of results.

```ruby
render BulmaPhlex::Pagination.new(@products, ->(page) { products_path(page: page) })
```

The first argument must be a pager object responding to `current_page`, `total_pages`, `per_page`, `total_count`, `previous_page`, and `next_page`.


### Progress Bar

Renders a [Bulma progress bar](https://bulma.io/documentation/elements/progress/) element. Supports color and size options.

```ruby
render BulmaPhlex::ProgressBar.new(color: "success", size: "large", value: 75, max: 100) { "75%" }
```

Omitting `value:` and `max:` produces an indeterminate (animated) progress bar.


### Table

Renders a [Bulma table](https://bulma.io/documentation/elements/table/) for a collection of records. Columns are defined via builder methods on the yielded component.

```ruby
render BulmaPhlex::Table.new(@users, fullwidth: true, hoverable: true) do |table|
  table.column("Name") { |user| user.full_name }
  table.column("Email", &:email)
  table.column("Actions") do |user|
    link_to "Edit", edit_user_path(user), class: "button is-small"
  end
end
```

In addition to `column`, two specialized column methods are available:

- `date_column(header, format: "%Y-%m-%d")` — formats the value with `strftime`
- `conditional_icon(header, icon_class: "fas fa-check")` — shows an icon when the block returns truthy

To add pagination to the table, call `paginate` with a block that returns a path given a page number:

```ruby
table.paginate { |page| products_path(page: page) }
```

Hide columns on smaller screens with the column `hidden` option:

```ruby
table.column("Email", hidden: { mobile: true }) { |user| user.email }
```


### Tabs

Renders a [Bulma tabs](https://bulma.io/documentation/components/tabs/) component with tabbed navigation and associated content panels. Supports alignment, size, and style options (boxed, toggle, rounded, fullwidth).

```ruby
render BulmaPhlex::Tabs.new(boxed: true) do |tabs|
  tabs.tab(id: "profile", title: "Profile", active: true) { "Profile content" }
  tabs.tab(id: "settings", title: "Settings", icon: "fas fa-cog") { "Settings content" }
end
```

Tab switching is handled by the `bulma-phlex--tabs` Stimulus controller. The controller is not included in this gem; an [example implementation](https://github.com/RockSolt/bulma-phlex-rails/blob/main/app/javascript/controllers/bulma_phlex/tabs_controller.js) is available in the `bulma-phlex-rails` gem. Pass a custom `data_attributes_builder:` to integrate with a different JavaScript setup.

An optional right-side element (e.g. a button) can be placed alongside the tab bar via `right_content`.


### Tag

Renders the [Bulma tag](https://bulma.io/documentation/elements/tag/) component. Supports color, size, rounded, and an optional inline delete button.

```ruby
render BulmaPhlex::Tag.new("New", color: "primary", rounded: true)
render BulmaPhlex::Tag.new("Sale", light: "danger")
```

The element type is inferred from the attributes: an `href:` produces an `<a>`, a `data-action` or `delete: true` produces a `<button>`, and otherwise a `<span>` is used.


### Title and Subtitle

Renders a [Bulma title](https://bulma.io/documentation/elements/title/) with an optional subtitle. Supports sizes 1–6 for both elements and a `spaced:` option to increase the gap between them.

```ruby
render BulmaPhlex::Title.new("Hello World")
render BulmaPhlex::Title.new("Dr. Strangelove", size: 2, subtitle: "Or: How I Learned to Stop Worrying and Love the Bomb")
```

When `size:` is set but `subtitle_size:` is not, the subtitle size defaults to `size + 2`.


## Upgrading to 0.8

> [!IMPORTANT]
> The 0.8.0 release includes breaking changes. The namespace for the components has been changed from `Components::Bulma` to `Components::BulmaPhlex`.

This can generally be handled with a *Find-and-Replace*:

**Find:** `Bulma::`
**Replace:** `BulmaPhlex::`

Note that this change was also applied to the expected Stimulus controllers. References such as the Navigation bar have been updated from `bulma--navigation-bar` to `bulma-phlex--navigation-bar`.

Finally, the optional Rails extensions for the Card and Table components have been moved to the `bulma-phlex-rails` gem. If you are using this with Rails, you should use [the `bulma-phlex-rails` gem](https://github.com/RockSolt/bulma-phlex-rails). It provides both the component extensions as well as JavaScript for the Dropdown, Navigation Bar, and Tabs components.


## Development

After checking out the repo, run `bundle install` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

### The `self.new` Pattern

Each component that defines `initialize` also defines a dummy `self.new` that does nothing but call `super`. This exists solely to support hover documentation in editors using [Ruby LSP](https://shopify.github.io/ruby-lsp/).

Phlex defines its own `self.new` on the base class (`Phlex::SGML`). Because Ruby LSP resolves hover documentation by walking the ancestor chain and stopping at the first definition it finds, it would otherwise show Phlex's generic comment for every component's `.new` call rather than the component's own parameter documentation. Defining a local `self.new` gives Ruby LSP a component-level entry point to attach comments to.

The `self.new` method must match the signature of `initialize` and be preceded by a comment documenting its parameters. A custom RuboCop cop (`RuboCop::Cop::BulmaPhlex::PhlexNewMethod`) enforces this convention.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/RockSolt/bulma-phlex.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Credits

This leverages the [Bulma CSS library](https://bulma.io/documentation/) and [Phlex](https://www.phlex.fun/) but is not endorsed or certified by either. We are fans of both and this makes using them together easier.
