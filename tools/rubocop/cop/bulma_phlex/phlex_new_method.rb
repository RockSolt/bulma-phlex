# frozen_string_literal: true

module RuboCop
  module Cop
    module BulmaPhlex
      # Enforces that Phlex component classes that define `initialize` also define a
      # `self.new` method that only calls `super`, so that hover documentation is
      # visible in editors using Ruby LSP. The `self.new` method must also have a
      # comment documenting its parameters, and its parameter list must exactly
      # match `initialize`.
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
      #   # bad - self.new signature doesn't match initialize
      #   class MyComponent < Phlex::HTML
      #     # **Parameters**
      #     # - `title` — The title text
      #     def self.new(title:)
      #       super
      #     end
      #
      #     def initialize(title:, subtitle: nil)
      #       @title = title
      #       @subtitle = subtitle
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
        MSG_SIGNATURE = "`self.new` parameters must match `initialize` exactly."
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

          children = class_body_children(node)
          return if children.nil?
          return unless defines_initialize?(children)

          check_new_method(node, children)
        end

        private

        def class_body_children(node)
          body = node.body
          return nil if body.nil?

          body.begin_type? ? body.children : [body]
        end

        def defines_initialize?(children)
          children.any? { |n| n.def_type? && n.method_name == :initialize }
        end

        def check_new_method(node, children) # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
          new_method = children.find { |child| self_new_def?(child) }
          init_method = children.find { |child| child.def_type? && child.method_name == :initialize }

          if new_method.nil?
            add_offense(node.loc.keyword, message: MSG_MISSING)
          elsif invalid_new_method_body?(new_method)
            add_offense(new_method, message: MSG_BODY)
          elsif mismatched_signature?(new_method, init_method)
            add_offense(new_method, message: MSG_SIGNATURE)
          elsif !preceding_comment?(new_method)
            add_offense(new_method, message: MSG_COMMENT)
          end
        end

        def invalid_new_method_body?(new_method)
          !only_super?(new_method.body)
        end

        # Returns true when the parameter lists of `self.new` and `initialize` differ.
        #
        # Each parameter is represented as a tuple of [type, name, default_source] where
        # `default_source` is the source text of the default-value expression (present only
        # for `optarg` and `kwoptarg` nodes). Two signatures are equal when every element
        # of those tuples matches in order.
        def mismatched_signature?(new_method, init_method)
          param_signature(new_method.arguments) != param_signature(init_method.arguments)
        end

        # Normalises an array of argument nodes into a comparable list of tuples.
        def param_signature(args)
          args.map do |arg|
            name = arg.children[0]
            default = arg.children[1]
            if default
              [arg.type, name, default.source]
            else
              [arg.type, name]
            end
          end
        end

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
          resolved = const_to_string(node)
          resolved == name || resolved == name.split("::").last
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
