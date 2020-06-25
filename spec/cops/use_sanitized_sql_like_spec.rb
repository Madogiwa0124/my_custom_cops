# frozen_string_literal: true

require_relative '../spec_helper.rb'
require_relative '../../cops/use_sanitized_sql_like.rb'

describe CustomCops::UseSanitizedSqlLike do
  subject(:cop) { described_class.new }

  it 'raised offense when not use `sanitize_sql_like`' do
    title = 'foo'
    expect_offense(<<~RUBY)
      Foo.where('title LIKE ?', "%#{title}%")
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use sanitize_sql_like when execute `LIKE` query in where.
    RUBY
  end
end
