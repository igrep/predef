require_relative 'test_helper'

class Hoge
  def foo arg
    'bar ' + arg
  end
  def foo2
    'original foo2'
  end
  def foo3
  end
  def never_predef_ed
  end

  def self.singleton_method arg
    'singleton_bar ' + arg
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

example 'Predef.predef overrides a singleton method of a object' do

  Predef.predef Hoge.singleton_class, :singleton_method do|arg|
    super(arg) + ' baz'
  end

  actual = Hoge.singleton_method('arg')
  expected = 'singleton_bar arg baz'
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

example 'Predef.predef raises an error given an undefined method.' do
  actual = error_of do
    Predef.predef Hoge, :non_defined do
    end
  end
  expected = ::Predef::Error
  test(
    (actual.instance_of? expected),
    "Expected an instance of #{actual.class} to be an instance of #{expected}."
  )
end

example 'Predef.predef! does NOT raise an error given even an undefined method.' do
  actual = error_of do
    Predef.predef! Hoge, :non_defined do
    end
  end
  test(actual.nil?, "Expected an instance of #{actual.inspect} to nil.")
end

example 'Predef.unpredef gets back orignal method.' do
  Predef.unpredef Hoge, :foo2

  actual = Hoge.new.foo2
  expected = 'original foo2'
  test(
    (actual == expected),
    "Expected #{actual.inspect} to equal to #{expected.inspect}."
  )
end

example 'Predef.unpredef raises an error given a non predef-ed class.' do
  class AnotherClass
    def foo
    end
  end

  actual = error_of { Predef.unpredef AnotherClass, :foo }
  expected = ::Predef::Error
  test(
    (actual.instance_of? expected),
    "Expected an instance of #{actual.class} to be an instance of #{expected}."
  )
end

example 'Predef.unpredef raises an error given a non predef-ed method.' do
  actual = error_of { Predef.unpredef Hoge, :never_predef_ed }
  expected = ::Predef::Error
  test(
    (actual.instance_of? expected),
    "Expected an instance of #{actual.class} to be an instance of #{expected}."
  )
end

example 'Hoge.predef raises a NoMethodError without using Predef::Refinements' do
  actual = error_of { Hoge.predef(:foo3){ :foo3 } }
  expected = ::NoMethodError
  test(
    (actual.instance_of? expected),
    "Expected an instance of #{actual.class} to be an instance of #{expected}."
  )
end

using ::Predef::Refinements

example "Hoge.predef doesn't raise an error by using Predef::Refinements" do
  Hoge.predef(:foo3){ :foo3 }
  actual = Hoge.new.foo3
  expected = :foo3
  test(
    (actual == expected),
    "Expected #{actual.inspect} to equal to #{expected.inspect}."
  )
end
