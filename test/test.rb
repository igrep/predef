require_relative 'test_helper'

class Hoge
  def foo arg
    'bar ' + arg
  end
end

example 'Predef overrides methods of a class' do
  Predef.predef Hoge, :foo do|arg|
    super(arg) + ' baz'
  end

  actual = Hoge.new.foo('arg')
  expected = 'bar arg baz'
  test(
    'overridden method can use super.',
    (actual == expected),
    "Expected #{actual.inspect} to equal to #{expected.inspect}."
  )
end
