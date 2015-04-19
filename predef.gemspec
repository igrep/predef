# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'predef'

Gem::Specification.new do |spec|
  spec.name          = "predef"
  spec.version       = Predef::VERSION
  spec.authors       = ["Yuji Yamamoto"]
  spec.email         = ["whosekiteneverfly@gmail.com"]
  spec.summary       = %q{Shortcut for prepend-ing Module.}
  spec.description   = %q{Shortcut for prepend-ing Module. Maybe useful for debugging.}
  spec.homepage      = "https://github.com/igrep/predef"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = []
  spec.test_files    = ["README.md"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rubydoctest", ">= 1.1.5"

  spec.required_ruby_version = '>= 2.0'
end
