[![Gem Version](https://badge.fury.io/rb/bulma-phlex.svg)](https://badge.fury.io/rb/bulma-phlex)
[![Tests](https://github.com/RockSolt/bulma-phlex/actions/workflows/test.yml/badge.svg)](https://github.com/RockSolt/bulma-phlex/actions/workflows/test.yml)
[![RuboCop](https://github.com/RockSolt/bulma-phlex/actions/workflows/rubocop.yml/badge.svg)](https://github.com/RockSolt/bulma-phlex/actions/workflows/rubocop.yml)

# Bulma Components Built with Phlex

This gem provides a set of ready-to-use components [Phlex](https://github.com/phlex-ruby/phlex) for common [Bulma](https://bulma.io/) components and elements, making it easy to build beautiful, responsive interfaces with a clean, Ruby-focused API.

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
render Components::Bulma::Card.new do |card|
  card.head("Card Title")
  card.content do
    "This is some card content"
  end
end
```

### Dropdown

The [Dropdown](https://bulma.io/documentation/components/dropdown/) component provides a flexible dropdown menu for navigation or actions. It supports both click-to-toggle (default, requires a Stimulus controller) and hoverable modes, as well as alignment and icon customization.

```ruby
render Components::Bulma::Dropdown.new("Next Actions...") do |dropdown|
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
render Components::Bulma::Level.new do |level|
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
render Components::Bulma::NavigationBar.new do |navbar|
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

### Pagination

The [Pagination](https://bulma.io/documentation/components/pagination/) component provides navigation controls for paginated content, including previous/next links, page number links, and a summary of items being displayed.

```ruby
# In a controller action:
@products = Product.page(params[:page]).per(20)

# In the view:
render Components::Bulma::Pagination.new(@products, ->(page) { products_path(page: page) })
```

### Table

The [Table](https://bulma.io/documentation/elements/table/) component provides a way to display data in rows and columns with customizable headers and formatting options.

It requires a Hotwired Stimulus controller to manage the tabs and the content. By default, the controller name is assumed to be `bulma--tabs`, but can be overridden with the constructor keyword argument `stimulus_controller`. Stimulus targets and actions are added to the component.

```ruby
users = User.all

render Components::Bulma::Table.new(users) do |table|
  table.column "Name" do |user|
    user.full_name
  end

  table.column "Email" do |user|
    user.email
  end

  table.column "Actions" do |user|
    link_to "Edit", edit_user_path(user), class: "button is-small"
  end
end
```

### Tabs

The [Tabs](https://bulma.io/documentation/components/tabs/) component provides a way to toggle between different content sections using tabbed navigation, with support for icons and active state management.

```ruby
render Components::Bulma::Tabs.new do |tabs|
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

## Development

After checking out the repo, run `bundle install` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/RockSolt/bulma-phlex.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
