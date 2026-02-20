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
  - [Form Field](#form-field)
  - [Grid](#grid)
  - [Hero](#hero)
  - [Icon](#icon)
  - [Level](#level)
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

The [Button](https://bulma.io/documentation/elements/button/) component provides a way to create styled buttons with various options for colors, sizes, and icons.

```ruby
BulmaPhlex::Button(color: "primary", size: "large", icon: "fas fa-thumbs-up") { "Like" }
```

The component can generate a button, anchor, or input element. By default it generates a `<button>`
element. If the `href` attribute is provided, it generates an `<a>` element. To generate an `<input>`
element, use the keyword argument `input` with a value of the type of input (button, reset, or submit).


**Constructor Keyword Arguments:**

- `color`: Sets the button color (e.g., "primary", "link", "info", "success", "warning", "danger").
- `mode`: Sets the mode of the notification: "light" or "dark".
- `size`: Sets the button size: "small", "normal" (the default), "medium", or "large".
- `responsive`: If `true`, makes the button responsive.
- `fullwidth`: If `true`, makes the button full width.
- `outlined`: If `true`, makes the button outlined.
- `inverted`: If `true`, makes the button inverted.
- `rounded`: If `true`, makes the button rounded.
- `input`: If provided, generates an `input` element instead of a `button`. The value should be the type of input: "button", "reset", or "submit".
- `icon`: If provided, adds an icon to the button. Should be a string representing the 
  icon class (e.g., "fa-solid fa-check").
- `icon_left`: If provided, adds an icon to the left of the button text. Should be a string
  representing the icon class (e.g., "fa-solid fa-check").
- `icon_right`: If provided, adds an icon to the right of the button text. Should be a string
  representing the icon class (e.g., "fa-solid fa-check").

Any additional HTML attributes passed to the constructor will be applied to the button element.


### Card

[Cards](https://bulma.io/documentation/components/card/) are flexible containers that can display various types of content including headers and content sections.

```ruby
BulmaPhlex::Card() do |card|
  card.head("Card Title")
  card.content do
    "This is some card content"
  end
  card.footer_link("View", "/view", target: "_blank")
  card.footer_link("Edit", "/edit", class: "has-text-primary")
end
```

**Constructor Arguments:**

- `html_attributes`: Any additional HTML attributes to be passed to the card container div.

**Arguments for `footer_link`:**

- text: the link text
- href: passed to the anchor's `href` attribute
- Any additional HTML attributes can be passed as keyword arguments.

Icons can be added to the links by passing an `icon` keyword argument with the icon class:

```ruby
  card.footer_link("View", "/view", icon: "fas fa-eye")
```


### Columns

The [Columns](https://bulma.io/documentation/columns/basics/) component provides a way to create responsive columns layouts using Bulma's column classes. It generates the wrapping `div` with the `columns` class and handles all the options.

```ruby
BulmaPhlex::Columns(gap: 4, multiline: true) do
  div(class: "column is-one-third") { "Column 1" }
  div(class: "column is-one-third") { "Column 2" }
  div(class: "column is-one-third") { "Column 3" }
end
```

**Constructor Keyword Arguments:**

- `minimum_breakpoint`: (Symbol, optional) Sets the minimum breakpoint for the columns; default is `:tablet`.
- `multiline`: (Boolean, optional) If true, allows the columns to wrap onto multiple lines.
- `gap`: (optional) Use an integer (0-8) to set the gap size between columns; use a hash keyed by breakpoints
  to set responsive gap sizes.
- `centered`: (Boolean, optional) If true, centers the columns.
- `vcentered`: (Boolean, optional) If true, vertically centers the columns.



### Dropdown

The [Dropdown](https://bulma.io/documentation/components/dropdown/) component provides a flexible dropdown menu for navigation or actions. It supports both click-to-toggle (default, requires a Stimulus controller) and hoverable modes, as well as alignment and icon customization.

```ruby
BulmaPhlex::Dropdown("Next Actions...") do |dropdown|
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
- `click` (keyword): Stimulus controller name for click-to-toggle (default: `"bulma-phlex--dropdown"`). Set to `false` for hoverable.
- `alignment` (keyword): `:left` (default), `:right`, or `:up`.
- `icon` (keyword): Icon class for the dropdown arrow (default: `"fas fa-angle-down"`).
- `html_attributes`: Any additional HTML attributes to be passed to the dropdown container div.

**Dropdown methods:**

- `link(label, path)`: Adds a link item.
- `item(content = nil, &block)`: Adds a custom item (string or block).
- `divider`: Adds a divider line.


### Form Field

The [Form Field](https://bulma.io/documentation/form/general/) component provides a way to create form fields with labels, inputs, and help text, following Bulma's form styling conventions. It also supports adding icons to the input, as well as tagging the field as a column or grid cell.

```ruby
BulmaPhlex::FormField(help: "We'll never share your email.") do |field|
  field.label("Email Address")
  field.control { input(name: "user[email_address]", type: "email") }
end
```

The label can be passed in as a string or created with a block:

```ruby
  field.label do
    span { "Email Address" }
    span(class: "has-text-danger") { "*" }
  end
```

**Constructor Keyword Arguments:**

- `icon_left`: Icon class to display on the left side of the input (such as `fas fa-user`).
- `icon_right`: Icon class to display on the right side of the input.
- `help`: Help text to display below the field.
- `column`: When true, adds the `column` class to the container. Can also be a string specifying the column size (such as `two-thirds`) or a hash with sizes by breakpoint (such as `{ mobile: "full", desktop: "half" }`).
- `grid`: When true, adds the `cell` class to the container. Can also be a string specifying the heighth or width of the cell (such as `col-span-3`).


### Grid

The [Grid](https://bulma.io/documentation/grid/smart-grid/) component provides a flexible grid layout system using Bulma's grid classes.

```ruby
BulmaPhlex::Grid(minimum_column_width: 16) do
  @tiles.each do |tile|
    div(class: "cell") do
      ... render tile ...
    end
  end
end
```

**Constructor Keyword Arguments:**

- `fixed_columns`: (Integer, optional) Specifies a fixed number of columns for the grid.
- `auto_count`: (Boolean, optional) If true, the grid will automatically adjust the number
    of columns based on the breakpoint.
- `minimum_column_width`: (Integer 1-32, optional) Sets a minimum width for the columns in the grid.
- `gap`: (optional) Sets the gap size between grid items, from 1-8 with 0.5 increments.
- `column_gap`: (optional) Sets the column gap size between grid items, from 1-8 with 0.5 increments.
- `row_gap`: (optional) Sets the row gap size between grid items, from 1-8 with 0.5 increments.



### Hero

The [Hero](https://bulma.io/documentation/layout/hero/) component provides a large, full-width section for showcasing important content or calls to action, with support for different sizes and colors.

There are three ways to invoke the component:

- with a title and subtitle argument
- with a block for the hero body content
- invoke methods head, body, and footer on the yielded component and pass blocks to define each section

Additionally, both the size and color of the Hero can be specified through keyword arguments in the
constructor. Any additional HTML attributes given to the constructor will be added to the containing `div`.

```ruby
BulmaPhlex::Hero(title: "Welcome to My Site", subtitle: "We're glad you're here!", color: "primary")
```


### Icon

The [Icon](https://bulma.io/documentation/elements/icon/) component provides a way to display icons using Font Awesome or other icon libraries, with support for different sizes and colors.

```ruby
BulmaPhlex::Icon("fas fa-user", size: "large", color: "primary")
```

**Constructor Arguments:**

- `icon_class`: (positional, required) The icon class to display (such as `fas fa-user`).
- `size`: (optional) The [Bulma icon size](https://bulma.io/documentation/elements/icon/#sizes): small, medium, large.
- `color`: (optional) The [Bulma color class](https://bulma.io/documentation/elements/icon/#colors) to apply.
- `text_right`: (optional) Text to display to the right of the icon.
- `text_left`: (optional) Text to display to the left of the icon.
- `left`: (optional) If true, adds the `is-left` class for use in form controls.
- `right`: (optional) If true, adds the `is-right` class for use in form controls.

Any additional HTML attributes are passed to the icon container span.


### Level

The [Level](https://bulma.io/documentation/layout/level/) component provides a flexible horizontal layout system with left and right alignment.

```ruby
BulmaPhlex::Level() do |level|
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

Pass in any HTML attributes to the constructor to have them applied to the level container div.


### Modal

The [Modal](https://bulma.io/documentation/components/modal/) component provides a way to create modal dialogs with customizable content and styling options.

```ruby
BulmaPhlex::Modal.new do
  div(class: "box") do
    h1(class: "title") { "Modal Title" }
    p { "This is the modal content." }
  end
end
```

**Constructor Keyword Arguments:**

- `data_attributes_builder`: A builder object that responds to `for_container`, `for_background`, and `for_close_button`, which should return a hash of data attributes for the container, background, and close button, respectively. By default, this uses the nested `StimulusDataAttributes` class with the controller name `bulma-phlex--modal`. You can create your own builder to integrate with a different JavaScript framework or custom logic.

Any additional HTML attributes passed to the constructor will be applied to the modal container div. The modal can be toggled by adding or removing the `is-active` class on the container. (Nothing in the component adds the `is-active` class, so you will need to handle that with your own JavaScript or Stimulus controller.)


### NavigationBar

The [NavigationBar](https://bulma.io/documentation/components/navbar/) component provides a responsive navigation header with support for branding, navigation links, and dropdown menus.

```ruby
BulmaPhlex::NavigationBar(classes: "is-primary") do |navbar|
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

- `container`: When true, wraps the content in a Bulma container. To set a constraint, such as "is-max-desktop", pass that string instead of true. (defaults to false)
- `color`: Sets the navbar color (e.g., "primary", "light", "dark").
- `transparent`: If `true`, makes the navbar transparent.
- `spaced`: If `true`, adds spacing to the navbar.
- `shadow`: If `true`, adds a shadow to the navbar.

Any additional HTML attributes passed to the component will be applied to the `<nav>` element.

> [!NOTE]  
> Adding a container will limit the width of the Navigation Bar content according to Bulma's container rules. However, the background color of the navbar will still span the full width of the viewport.


### Notification

The [Notification](https://bulma.io/documentation/components/notification/) component provides a way to display messages or alerts with customizable styles and a close button.

```ruby
BulmaPhlex::Notification(color: "info", delete: true) do
  "This is an informational notification with a close button."
end
```

The `delete` keyword argument adds a close button to the notification. In addition to setting it to `true`, it can also be a hash of HTML attributes for the button, such as a data attribute to hook into a Stimulus controller.

```ruby
BulmaPhlex::Notification(color: "warning", delete: { data: { controller: "bulma-phlex--notification" } }) do
  "This is a warning notification with a close button that works with a Stimulus controller."
end
```

**Constructor Keyword Arguments:**

- `delete`: (optional) When true, adds a close button to the notification. Can also be a hash of HTML attributes for the button.
- `color`: (optional) The [Bulma color class](https://bulma.io/documentation/elements/tag/#colors) to apply.
- `mode`: Sets the mode of the notification: "light" or "dark".

Any additional attributes are passed to the notification container div.

```ruby
BulmaPhlex::Notification(id: "my-notification", class: "ml-3") do
  "This is a notification with custom id and class."
end
```


### Pagination

The [Pagination](https://bulma.io/documentation/components/pagination/) component provides navigation controls for paginated content, including previous/next links, page number links, and a summary of items being displayed.

```ruby
BulmaPhlex::Pagination(@products, ->(page) { products_path(page: page) })
```

**Constructor Arguments:**

- `pager`: An object that responds to pagination methods (see below).
- `path_builder`: A lambda that takes a page number and returns the URL for that page. This is used to generate the links for the pagination controls.

Any additional HTML attributes passed to the constructor will be applied to the pagination container element.

In order to support pagination, the first argument in the constructor must repond with integers to the following:

- current_page
- total_pages
- per_page
- total_count
- previous_page (can be nil)
- next_page (can be nil)


### Progress Bar

The [Progress Bar](https://bulma.io/documentation/components/progress/) component provides a visual representation of progress or completion status, with support for different colors and sizes.

```ruby
BulmaPhlex::ProgressBar(color: "success", size: "large", value: 75, max: 100) { "75%" }
```

**Constructor Keyword Arguments:**

- `color`: (optional) The [Bulma color class](https://bulma.io/documentation/elements/progress/#colors) to apply.
- `size`: (optional) The [Bulma size class](https://bulma.io/documentation/elements/progress/#sizes) to apply: small, medium, or large.
- `html_attributes`: Any additional HTML attributes to be passed to the `progress` element. Include the `value` and `max` attributes here to set the progress level.

Leaving out the `value` and `max` attributes will render an indeterminate progress bar, which can be used to indicate that a process is ongoing without specifying the exact progress.



### Table

The [Table](https://bulma.io/documentation/elements/table/) component provides a way to display data in rows and columns with customizable headers and formatting options.

```ruby
users = User.all

BulmaPhlex::Table(users, fullwidth: true, hoverable: true) do |table|
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
- `bordered`: adds the `is-bordered` class (boolean, defaults to false)
- `striped`: adds the `is-striped` class (boolean, defaults to false)
- `narrow`: adds the `is-narrow` class (boolean, defaults to false)
- `hoverable`: adds the `is-hoverable` class (boolean, defaults to false)
- `fullwidth`: adds the `is-fullwidth` class (boolean, defaults to false)

Any additional HTML attributes passed to the constructor will be applied to the table element.

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

This generates the [Bulma pagination](https://bulma.io/documentation/components/pagination/) component, providing navigation controls for paginated content. The rows argument is passed into the Pagination component to determine the current page, total pages, and other pagination details.


### Tabs

The [Tabs](https://bulma.io/documentation/components/tabs/) component provides a way to toggle between different content sections using tabbed navigation, with support for icons and active state management.

Behavior of the tabs can be driven by the data attributes, which are assigned by the object passed in as the `data_attributes_builder`. By default, this will use the `StimulusDataAttributes` class with the controller name `bulma-phlex--tabs`. The controller is not provided by this library, but you can create your own Stimulus controller to handle the tab switching logic. Here is [an implementation of a Stimulus controller for Bulma tabs](https://github.com/RockSolt/bulma-phlex-rails/blob/main/app/javascript/controllers/bulma_phlex/tabs_controller.js).

```ruby
BulmaPhlex::Tabs(boxed: true) do |tabs|
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

- `align`: Can be `centered` or `right` to align the tabs accordingly.
- `size`: Can be `small`, `medium`, or `large` to set the size of the tabs.
- `boxed`: If `true`, uses classic style tabs.
- `toggle`: If `true`, makes the tabs look like buttons.
- `rounded`: If `true`, makes the tabs look like buttons with the first and last rounded.
- `fullwidth`: If `true`, makes the tabs take up the full width of the container.
- `data_attributes_builder`: Builder object that responds to `for_container`, `for_tab`, and `for_content` (with the latter two receiving the tab `id`). See the default `StimulusDataAttributes` for an example.

Any additional HTML attributes passed to the component will be applied to the outer `<div>` element.

**Keyword Arguments for `tab` Method:**

- `id`: The id to be assigned to the content. The tab will be assigned the same id with the suffix `-tab`.
- `title`: The name on the tab.
- `active`: Adds the `is-active` class to the tab and shows the related content. Non-active content is assigned the `is-hidden` class. Defaults to `false`.
- `icon`: Specify an optional icon class.

### Tag

The [Tag](https://bulma.io/documentation/elements/tag/) component provides a way to display small, colored labels or tags with customizable styles. The component generates either a `span`, `a`, or `button` element based on the provided options and HTML attributes.

If the HTML attributes include an `href`, an anchor (`a`) element is generated; if not and either the `delete` option is true or there is a `data-action` attribute, a `button` element is generated; otherwise, a `span` element is used.

```ruby
BulmaPhlex::Tag("New", color: "primary", rounded: true)
BulmaPhlex::Tag("Sale", light: "danger")
```

**Constructor Arguments:**
- `text`: (positional, required) The tag text to display.
- `color`: (optional) The [Bulma color class](https://bulma.io/documentation/elements/tag/#colors) to apply.
- `light`: (optional) Use instead of `color` to apply a light color variant.
- `rounded`: (optional) A boolean indicating whether the tag should have rounded corners.
- `size`: (optional) The [Bulma tag size](https://bulma.io/documentation/elements/tag/#sizes): normal, medium, or large.
- `delete`: (optional) A boolean indicating whether to include a delete button on the tag.


### Title and Subtitle

The [Title](https://bulma.io/documentation/elements/title/) component provide a way to display headings and subheadings with customizable sizes and styles.

```ruby
BulmaPhlex::Title("Hello World")

BulmaPhlex::Title("Dr. Strangelove", size: 2, subtitle: "Or: How I Learned to Stop Worrying and Love the Bomb")
```

**Constructor Arguments:**

- `text`: (positional, required) The main title text to display.
- `size`: (optional) An integer from 1 to 6 indicating the size of the title. Corresponds to Bulma's `is-<size>` classes.
- `subtitle`: (optional) The subtitle text to display below the main title.
- `subtitle_size`: (optional) An integer from 1 to 6 indicating the size of the subtitle. If not provided and a title size is given, it defaults to `size + 2`.
- `spaced`: (optional) A boolean indicating whether to add the `is-spaced` class to the title.


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

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/RockSolt/bulma-phlex.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Credits

This leverages the [Bulma CSS library](https://bulma.io/documentation/) and [Phlex](https://www.phlex.fun/) but is not endorsed or certified by either. We are fans of both and this makes using them together easier.
