# frozen_string_literal: true

require 'rubocop'

module CustomCops
  # @example
  #   # bad
  #   Foo.where(id: Bar.pluck(:foo_id))
  #
  #   # good
  #   Foo.where(id: Bar.select(:foo_id))
  class UseSelectInWhere < RuboCop::Cop::Cop
    MSG = 'Use select instead of pluck in where to use subqueries to reduce SQL executions.'

    def_node_matcher :where_in_pluck_candidate?, <<~PATTERN
      (send _ :where (:hash (:pair (:sym _) (send _ :pluck (:sym _)) ...)))
    PATTERN

    def on_send(node)
      where_in_pluck_candidate?(node) do
        add_offense(node)
      end
    end

    def autocorrect(node)
      # TODO
    end
  end
end
