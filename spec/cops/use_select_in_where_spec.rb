# frozen_string_literal：true

require_relative '../spec_helper.rb'
require_relative '../../cops/use_select_in_where.rb'

describe CustomCops::UseSelectInWhere do
  subject(:cop) { described_class.new }

  it 'raised offense when use `pluck` in `where`.' do
    expect_offense(<<-RUBY)
      Foo.where(id: Bar.pluck(:foo_id))
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use select instead of pluck in where to use subqueries to reduce SQL executions.
    RUBY
  end
end
