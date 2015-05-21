class Predef < Module
  VERSION = "0.0.1"

  private_class_method :new

  def self.predef klass, method_name, &definition
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
    klass.__PREDEF__.module_eval do
      remove_method method_name
    end
  end

  def initialize klass
    prepend_features klass
  end

  module Refinements
  end

end
