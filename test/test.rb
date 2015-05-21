require_relative 'test_helper'

class Hoge
  def foo arg
    'bar ' + arg
  end
end

example 'Predef.predef overrides a method of a class' do
  note 'overridden method can use super.'
  Predef.predef Hoge, :foo do|arg|
    super(arg) + ' baz'
  end

  actual = Hoge.new.foo('arg')
  expected = 'bar arg baz'
  test(
    (actual == expected),
    "Expected #{actual.inspect} to equal to #{expected.inspect}."
  )
end
