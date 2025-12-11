[![Gem Version](https://badge.fury.io/rb/bulma-phlex.svg)](https://badge.fury.io/rb/bulma-phlex)
[![Tests](https://github.com/RockSolt/bulma-phlex/actions/workflows/test.yml/badge.svg)](https://github.com/RockSolt/bulma-phlex/actions/workflows/test.yml)
[![RuboCop](https://github.com/RockSolt/bulma-phlex/actions/workflows/rubocop.yml/badge.svg)](https://github.com/RockSolt/bulma-phlex/actions/workflows/rubocop.yml)

# Bulma Components Built with Phlex

This gem provides a set of ready-to-use [Phlex](https://github.com/phlex-ruby/phlex) components for common [Bulma](https://bulma.io/) components and elements, making it easy to build beautiful, responsive interfaces with a clean, Ruby-focused API.


> [!IMPORTANT]
> There are breaking changes in main, specifically around namespaces. Please refer to the latest released branch for [documentation of the current gem](https://github.com/RockSolt/bulma-phlex/tree/v0.7.0?tab=readme-ov-file#bulma-components-built-with-phlex).

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
  - [Card](#card)
  - [Dropdown](#dropdown)
  - [Level](#level)
  - [NavigationBar](#navigationbar)
  - [Pagination](#pagination)
  - [Table](#table)
  - [Tabs](#tabs)
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

- Ruby 3.4 or higher
- Phlex 2.0.2 or higher
- Bulma CSS (which you'll need to include in your application)

### Required Setup

1. Include Bulma CSS in your application. You can add it via npm/yarn, CDN, or the [bulma-rails](https://github.com/joshuajansen/bulma-rails) gem.

2. Require the gem in your code:

```ruby
require "bulma-phlex"
```


## Usage

Use the Phlex components in your Rails views or any Ruby application that supports Phlex components.

### Card

[Cards](https://bulma.io/documentation/components/card/) are flexible containers that can display various types of content including headers and content sections.

```ruby
Bulma::Card() do |card|
  card.head("Card Title")
  card.content do
    "This is some card content"
  end
  card.footer_link("View", "/view", target: "_blank")
  card.footer_link("Edit", "/edit", class: "has-text-primary")
end
```

**Arguments for `footer_link`:**

- text: the link text
- href: passed to the anchor's `href` attribute
- Any additional HTML attributes can be passed as keyword arguments.


### Dropdown

The [Dropdown](https://bulma.io/documentation/components/dropdown/) component provides a flexible dropdown menu for navigation or actions. It supports both click-to-toggle (default, requires a Stimulus controller) and hoverable modes, as well as alignment and icon customization.

```ruby
Bulma::Dropdown("Next Actions...") do |dropdown|
  dropdown.link "View Profile", "/profile"
  dropdown.link "Go to Settings", "/settings"
  dropdown.divider
  dropdown.item("This is just a text item")
  dropdown.item do
    div(class: "has-text-weight-bold") { "This is a bold item" }
  end
end
```

**Options:**

- `label` (required): The dropdown button label.
- `click`: Stimulus controller name for click-to-toggle (default: `"bulma--dropdown"`). Set to `false` for hoverable.
- `alignment`: `:left` (default), `:right`, or `:up`.
- `icon`: Icon class for the dropdown arrow (default: `"fas fa-angle-down"`).

**Dropdown methods:**

- `link(label, path)`: Adds a link item.
- `item(content = nil, &block)`: Adds a custom item (string or block).
- `divider`: Adds a divider line.

### Level

The [Level](https://bulma.io/documentation/layout/level/) component provides a flexible horizontal layout system with left and right alignment.

```ruby
Bulma::Level() do |level|
  level.left do
    button(class: "button") { "Left" }
  end

  level.right do
    button(class: "button") { "Right" }
  end
  level.right do
    button(class: "button") { "Right 2" }
  end
end
```

### NavigationBar

The [NavigationBar](https://bulma.io/documentation/components/navbar/) component provides a responsive navigation header with support for branding, navigation links, and dropdown menus.

```ruby
Bulma::NavigationBar(classes: "is-primary") do |navbar|
  navbar.brand_item "My App", "/"

  navbar.left do |menu|
    menu.item "Home", "/"
    menu.item "Products", "/products"
  end

  navbar.right do |menu|
    menu.item "About", "/about"
    menu.dropdown "Account" do |dropdown|
      dropdown.header "User"
      dropdown.item "Profile", "/profile"
      dropdown.item "Settings", "/settings"
      dropdown.divider
      dropdown.item "Sign Out", "/logout"
    end
  end
end
```

**Constructor Keyword Arguments:**

- `classes`: Additional classes to be added to the `nav` element, such as "is-primary" or "has-shadow".
- `container`: When true, wraps the content in a Bulma container. To set a constraint, such as "is-max-desktop", pass that string instead of true. (defaults to false)

> [!NOTE]  
> Adding a container will limit the width of the Navigation Bar content according to Bulma's container rules. The background color of the navbar will still span the full width of the viewport.

### Pagination

The [Pagination](https://bulma.io/documentation/components/pagination/) component provides navigation controls for paginated content, including previous/next links, page number links, and a summary of items being displayed.

```ruby
# In a controller action:
@products = Product.page(params[:page]).per(20)

# In the view:
Bulma::Pagination(@products, ->(page) { products_path(page: page) })
```

### Table

The [Table](https://bulma.io/documentation/elements/table/) component provides a way to display data in rows and columns with customizable headers and formatting options.

```ruby
users = User.all

Bulma::Table(users, fullwidth: true, hoverable: true) do |table|
  table.column "Name" do |user|
    user.full_name
  end

  # use the symbol-to-proc shortcut!
  table.column "Email", &:email

  table.column "Actions" do |user|
    link_to "Edit", edit_user_path(user), class: "button is-small"
  end
end
```

**Constructor Keyword Arguments:**

- `rows`: the data for the table as an enumerable (anything that responds to `each`)
- `id`: the Id for the table element (defaults to "table")
- `bordered`: adds the `is-bordered` class (boolean, defaults to false)
- `striped`: adds the `is-striped` class (boolean, defaults to false)
- `narrow`: adds the `is-narrow` class (boolean, defaults to false)
- `hoverable`: adds the `is-hoverable` class (boolean, defaults to false)
- `fullwidth`: adds the `is-fullwidth` class (boolean, defaults to false)

**Arguments for `column` Method:**

The `column` method takes the column name and any html attributes to be assigned to the table cell element. The block will be called with the row as the parameter.

#### Additional Column Types

Instead of calling `column`, you can also invoke the following methods to add date and icon columns:

**Arguments for `date_column`:**

- name: content for the `th` element
- `format` (keyword): the formatting options (will be passed to `strftime`, defaults to "%Y-%m-%d")

```ruby
  table.date_column("Due Date", format: "%B %d, %Y") { |row| row.due_date }
```

**Arguments for `conditional_icon`:**

The icon column is intended to show a boolean flag: a yes / no or an on / off. When the value is true the icon shows and when the value is false it does not.

- name: content for the `th` element
- `icon_class` (keyword): the icon to show (defaults to the Font Awesome check mark: "fas fa-check")

```ruby
  table.conditional_icon("Completed?", &:complete)
  table.conditional_icon("Approved?", icon_class: "fas fa-thumbs-up") { |row| row.status == "Approved" }
```

#### Pagination

If the table should be paginated, invoke method `paginate` with a block that will return a path given a page number.

```ruby
  table.paginate do |page_number|
    products_path(page: { number: page_number })
  end
```

In order to support pagination, the `rows` argument passed into the constructor must repond with integers to the following:

- current_page
- total_pages
- per_page
- total_count
- previous_page (can be nil)
- next_page (can be nil)

This generates the [Bulma pagination](https://bulma.io/documentation/components/pagination/) component, providing navigation controls for paginated content.


### Tabs

The [Tabs](https://bulma.io/documentation/components/tabs/) component provides a way to toggle between different content sections using tabbed navigation, with support for icons and active state management.

Behavior of the tabs can be driven by the data attributes, which are assigned by the object passed in as the `data_attributes_builder`. By default, this will use the `StimulusDataAttributes` class with the controller name `bulma--tabs`. The controller is not provided by this library, but you can create your own Stimulus controller to handle the tab switching logic. Here is [an implementation of a Stimulus controller for Bulma tabs](https://github.com/RockSolt/bulma-rails-helpers/blob/main/app/javascript/controllers/bulma/tabs_controller.js).

```ruby
Bulma::Tabs(tabs_class: "is-boxed", contents_class: "ml-4") do |tabs|
  tabs.tab(id: "profile", title: "Profile", active: true) do
    "Profile content goes here"
  end

  tabs.tab(id: "settings", title: "Settings", icon: "fas fa-cog") do
    "Settings content goes here"
  end

  tabs.tab(id: "notifications", title: "Notifications", icon: "fas fa-bell") do
    "Notifications content goes here"
  end
end
```

**Constructor Keyword Arguments:**

- `tabs_class`: Classes to be added to the tabs div, such as `is-boxed`, `is-medium`, `is-centered`, or `is-toggle`.
- `contents_class`: Classes added to the div that wraps the content (no Bulma related tabs functionality here, just a hook).
- `data_attributes_builder`: Builder object that responds to `for_container`, `for_tab`, and `for_content` (with the latter two receiving the tab `id`). See the default `StimulusDataAttributes` for an example.

**Keyword Arguments for `tab` Method:**

- `id`: The id to be assigned to the content. The tab will be assigned the same id with the suffix `-tab`.
- `title`: The name on the tab.
- `active`: Adds the `is-active` class to the tab and shows the related content. Non-active content is assigned the `is-hidden` class. Defaults to `false`.
- `icon`: Specify an optional icon class.


## Development

After checking out the repo, run `bundle install` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/RockSolt/bulma-phlex.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Credits

This leverages the [Bulma CSS library](https://bulma.io/documentation/) and [Phlex](https://www.phlex.fun/) but is not endorsed or certified by either. We are fans of the both and this makes using them together easier.
