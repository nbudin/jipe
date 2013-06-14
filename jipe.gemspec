# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jipe/version'

Gem::Specification.new do |spec|
  spec.name          = "jipe"
  spec.version       = Jipe::VERSION
  spec.authors       = ["Nat Budin"]
  spec.email         = ["natbudin@gmail.com"]
  spec.description   = %q{An in-place editor for Jester}
  spec.summary       = %q{A clone of Prototype's in-place edit controls for Thoughtbot's jester.js.  You might not wanna use this now that jQuery exists, but, in case you do, here it is.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rails", ">= 3.0.0"
end
