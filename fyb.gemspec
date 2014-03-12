# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fyb/version'

Gem::Specification.new do |spec|
  spec.name          = "fyb"
  spec.version       = Fyb::VERSION
  spec.authors       = ["Henrik Lundberg"]
  spec.email         = ["velfolt@gmail.com"]
  spec.summary       = %q{FYB v1 API implementation}
  spec.description   = %q{FYB v1 API implementation for easy access}
  spec.homepage      = "https://github.com/Velfolt/fyb"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_runtime_dependency 'weary', '~> 1.1.3'
  spec.add_runtime_dependency 'ruby-hmac', '~> 0.4.0'
  spec.add_runtime_dependency 'json'
  spec.add_runtime_dependency 'promise'
end
