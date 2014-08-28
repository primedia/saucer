# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'saucer/version'

Gem::Specification.new do |spec|
  spec.name          = "saucer"
  spec.version       = Saucer::VERSION
  spec.authors       = ["Zander Hill"]
  spec.email         = ["zander@xargs.io"]
  spec.summary       = %q{Interact with SauceLabs API.}
  spec.description   = %q{Interact with SauceLabs API.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
