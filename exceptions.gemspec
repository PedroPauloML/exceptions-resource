# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'exceptions/version'

Gem::Specification.new do |spec|
  spec.name          = "exceptions-resource"
  spec.version       = Exceptions::VERSION
  spec.authors       = ["Douglas Rossignolli"]
  spec.email         = ["douglas.rossignolli@gmail.com"]
  spec.summary       = %q{This small lib have many exceptions to work with rested exceptions and ActiveModel errors}
  spec.description   = %q{This small lib will play with many kinds of exceptions and return then as json with all needed informations to build awesome errors responses}
  spec.homepage      = "https://github.com/xdougx/exceptions-resource"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
