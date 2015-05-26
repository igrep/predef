class Predef < Module
  VERSION = "0.0.1"

  private_class_method :new

  def self.predef klass, method_name, &definition
    unless klass.public_method_defined? method_name
      raise ::Predef::Error, "#{klass}##{method_name} is not defined! Use `Predef.predef!` if you want to define a new method."
    end

    predef! klass, method_name, &definition
  end

  def self.predef! klass, method_name, &definition
    if defined? klass.__PREDEF__
      instance = klass.__PREDEF__
    else
      instance = new(klass)

      singleton_class = class << klass; self ; end
      singleton_class.class_eval do
        define_method(:__PREDEF__) { instance }
      end
    end

    instance.module_eval do
      define_method(method_name, &definition)
    end
    method_name
  end

  def self.unpredef klass, method_name
    if !(defined? klass.__PREDEF__) || !(klass.__PREDEF__.public_method_defined? method_name)
      raise ::Predef::Error, "#{klass}##{method_name} has never been predef-ed!"
    end
    self.unpredef! klass, method_name
  end

  def self.unpredef! klass, method_name
    klass.__PREDEF__.module_eval do
      remove_method method_name
    end
  end

  def initialize klass
    prepend_features klass
  end

  module Refinements
  end

  class Error < ::Exception
  end

end
