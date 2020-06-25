# frozen_string_literal: true

require 'rubocop'

module CustomCops
  # @example
  #   # bad
  #   Foo.where('title LIKE ?', "%#{title}%")
  #
  #   # good
  #   Foo.where('title LIKE ?', "%#{sanitized_sql_like(title)}%")
  class UseSanitizedSqlLike < RuboCop::Cop::Cop
    SANITIZED_METHOD_NAME = 'sanitized_sql_like'
    MSG = 'Use sanitize_sql_like when execute `LIKE` query in where.'

    def_node_matcher :where_use_str?, <<~PATTERN
      (send _ :where (:str _) ...)
    PATTERN

    def on_send(node)
      where_use_str?(node) do
        source = node.source.downcase
        sanitized = -> { source.include?(SANITIZED_METHOD_NAME) }
        add_offense(node) if source.include?('like') && !sanitized.call
      end
    end

    def autocorrect(node)
      # TODO
    end
  end
end
