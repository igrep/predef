module Predef
  VERSION = "0.0.1"

  def self.predef klass, method_name, &definition
  end

  def self.unpredef klass, method_name = nil
  end

  class PredefWrapper < ::Module
  end

end
