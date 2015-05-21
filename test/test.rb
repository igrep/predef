require_relative 'test_helper'

class Hoge
  def foo arg
    'bar ' + arg
  end
  def foo2
    'original foo2'
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

example 'Predef.predef overrides another method of the class' do
  Predef.predef Hoge, :foo2 do
    'baz2'
  end

  actual = Hoge.new.foo2
  expected = 'baz2'
  test(
    (actual == expected),
    "Expected #{actual.inspect} to equal to #{expected.inspect}."
  )
end

example 'Predef.unpredef get back orignal method.' do
  Predef.unpredef Hoge, :foo2 do
    'baz2'
  end

  actual = Hoge.new.foo2
  expected = 'original foo2'
  test(
    (actual == expected),
    "Expected #{actual.inspect} to equal to #{expected.inspect}."
  )
end
