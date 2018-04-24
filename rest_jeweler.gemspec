
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rest_jeweler/version"

Gem::Specification.new do |spec|
  spec.name          = "rest_jeweler"
  spec.version       = RestJeweler::VERSION
  spec.authors       = ["Christian Weyer"]
  spec.email         = ["cw@crispymtn.com"]

  spec.summary       = 'A foundation for REST API consumption gems'
  spec.description   = 'REST jeweler contains the foundation for quickly building gems that consume REST APIs'
  spec.homepage      = "https://www.github.com/crispymtn/rest_jeweler"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
