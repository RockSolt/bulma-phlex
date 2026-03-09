# Documentation Skills

## Class Comments

Every public component class has a top-level comment block directly above the class declaration. It covers:

1. **One-line description** with a Markdown link to the relevant Bulma docs page.
2. **Prose summary** of what the component supports — colour, size, style variants, builder methods, etc. This is what appears in hover previews, so it should be dense enough to orient a developer without them opening the file.
3. **`## Example` section** (where useful) showing the most representative invocation. Use plain indented Ruby, not a fenced code block, because YARD renders indented code correctly and it keeps the raw comment readable.

```ruby
# Renders a [Bulma notification](https://bulma.io/documentation/elements/notification/) component.
#
# A styled alert box for displaying messages to the user. Supports **color** and **style mode**
# (light/dark) options, and optionally includes a **dismiss button** whose HTML attributes
# can be customized. Content is provided via a block.
class Notification < BulmaPhlex::Base
```

Builder methods (methods called on the yielded component, like `card.head` or `tabs.tab`) each have their own comment directly above the method definition listing their parameters in the same style.

---

## The Dummy `self.new` Pattern

### Problem

Phlex defines `self.new` on its base class (`Phlex::SGML`). Ruby LSP resolves hover documentation by walking the ancestor chain and stopping at the **first** `self.new` definition it finds. Without intervention, every component shows Phlex's generic base-class comment on hover instead of the component's own parameter documentation.

### Solution

Every component that defines `initialize` also defines a dummy `self.new` that does nothing but call `super`. This gives Ruby LSP a component-level entry point with its own attached comment.

```ruby
# **Parameters**
# - `color` — Color of the notification (e.g. `"primary"`, `"info"`, `"danger"`)
# - `mode` — Style mode: `"light"` or `"dark"`
# - `delete` — If `true`, includes a delete button. Can also be a hash of HTML attributes for the button
# - `**html_attributes` — Additional HTML attributes for the notification element
def self.new(delete: false, color: nil, mode: nil, **html_attributes)
  super
end
```

### Rules

- `self.new` **must** match the signature of `initialize` exactly (same parameter names, defaults, and splat).
- The body **must** contain only `super` — no additional logic.
- A comment **must** immediately precede `self.new` documenting every parameter. Use the format:
  ```
  # **Parameters**
  # - `param_name` — Description
  ```
- Components with **no `initialize`** do not need a `self.new`.

### Enforcement

A custom RuboCop cop (`RuboCop::Cop::BulmaPhlex::PhlexNewMethod`) enforces all three rules. It flags:
- A class that has `initialize` but no `self.new`
- A `self.new` whose body does anything other than call `super`
- A `self.new` with no preceding comment

---

## README

The README is a **discovery and orientation document** — what someone reads before they have the code open in an editor. It is not a reference manual. The authoritative parameter reference lives in the class comments and RubyDoc.

### Per-component format

Each component section contains exactly three things:

1. **One-sentence description** with a link to the Bulma docs.
2. **A canonical usage example** — the most representative snippet, kept concise.
3. **A brief note on non-obvious behaviour** — anything that isn't apparent from the method signature alone (e.g. how the element type is inferred, which options accept a hash vs. a scalar, Stimulus controller dependencies, builder methods that aren't obvious from the constructor).

### What the README does not include

- Full parameter lists with types and defaults — those belong in the class comment.
- Exhaustive lists of builder method arguments — a one-line mention that the method exists is enough; the class comment carries the detail.
- Duplicate prose that restates what is already clear from the example.

### Maintenance principle

Whenever a parameter is added, renamed, or removed, **only the class comment needs updating**. The README should need changes only when the component's fundamental usage pattern changes or when a non-obvious behavioural note becomes outdated.