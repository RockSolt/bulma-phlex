# frozen_string_literal: true

module RuboCop
  module Cop
    module BulmaPhlex
      # Enforces that Phlex component classes that define `initialize` also define a
      # `self.new` method that only calls `super`, so that hover documentation is
      # visible in editors using Ruby LSP. The `self.new` method must also have a
      # comment documenting its parameters.
      #
      # Components without an `initialize` method do not need a `self.new`.
      #
      # The list of ancestor classes that trigger this cop is configurable via the
      # `Ancestors` option. It defaults to `["Phlex::HTML"]` but can be extended to
      # include any other base classes.
      #
      # @example
      #   # bad - has initialize but missing self.new
      #   class MyComponent < Phlex::HTML
      #     def initialize(title:)
      #       @title = title
      #     end
      #   end
      #
      #   # bad - self.new has extra logic
      #   class MyComponent < Phlex::HTML
      #     def self.new(title:)
      #       puts "creating"
      #       super
      #     end
      #
      #     def initialize(title:)
      #       @title = title
      #     end
      #   end
      #
      #   # bad - self.new has no comment
      #   class MyComponent < Phlex::HTML
      #     def self.new(title:)
      #       super
      #     end
      #
      #     def initialize(title:)
      #       @title = title
      #     end
      #   end
      #
      #   # good - has initialize, matching self.new, and a comment
      #   class MyComponent < Phlex::HTML
      #     # **Parameters**
      #     # - `title` — The title text
      #     def self.new(title:)
      #       super
      #     end
      #
      #     def initialize(title:)
      #       @title = title
      #     end
      #   end
      #
      #   # good - no initialize, no self.new needed
      #   class MyComponent < Phlex::HTML
      #     def view_template
      #       div { "Hello" }
      #     end
      #   end
      class PhlexNewMethod < Base
        MSG_MISSING = "Define a `self.new` method that only calls `super` so that " \
                      "hover documentation is visible in editors using Ruby LSP."
        MSG_BODY = "`self.new` must only call `super`."
        MSG_COMMENT = "`self.new` must have a comment documenting its parameters."

        # @!method self_new_def?(node)
        def_node_matcher :self_new_def?, <<~PATTERN
          (defs (self) :new ...)
        PATTERN

        # @!method only_super?(node)
        def_node_matcher :only_super?, <<~PATTERN
          {(zsuper) (super ...)}
        PATTERN

        def on_class(node)
          return unless phlex_subclass?(node)

          body = node.body
          return if body.nil?

          children = body.begin_type? ? body.children : [body]
          return unless children.any? { |n| n.def_type? && n.method_name == :initialize }

          new_method = children.find { |child| self_new_def?(child) }

          if new_method.nil?
            add_offense(node.loc.keyword, message: MSG_MISSING)
          elsif !only_super?(new_method.body)
            add_offense(new_method, message: MSG_BODY)
          elsif !preceding_comment?(new_method)
            add_offense(new_method, message: MSG_COMMENT)
          end
        end

        private

        def preceding_comment?(node)
          processed_source.ast_with_comments[node].any?
        end

        def ancestors
          cop_config.fetch("Ancestors", ["Phlex::HTML"])
        end

        def phlex_subclass?(node)
          superclass = node.parent_class
          return false if superclass.nil?

          ancestors.any? { |ancestor| matches_const?(superclass, ancestor) }
        end

        def matches_const?(node, name)
          const_to_string(node) == name
        end

        def const_to_string(node)
          return nil unless node.const_type?

          parts = []
          current = node
          while current&.const_type?
            parts.unshift(current.short_name.to_s)
            current = current.namespace
          end
          # if the chain started from cbase (leading ::), prepend nothing — the
          # parts already represent the full qualified name
          parts.join("::")
        end
      end
    end
  end
end
