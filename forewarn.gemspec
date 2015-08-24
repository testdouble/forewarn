# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'forewarn/version'

Gem::Specification.new do |spec|
  spec.name          = "forewarn"
  spec.version       = Forewarn::VERSION
  spec.authors       = ["Justin Searls"]
  spec.email         = ["searls@gmail.com"]

  spec.summary       = %q{log deprecated or unsafe method invocations}
  spec.description   = %q{allows users to write and configure their own method blacklists to warn of dangerous invocations (e.g. deprecated methods, unsafe methods after an impending upgrade, etc.)}
  spec.homepage      = "https://github.com/testdouble/forewarn"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features|docs)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
end
