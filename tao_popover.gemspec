# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tao_popover/rails/version'

Gem::Specification.new do |spec|
  spec.name          = "tao_popover"
  spec.version       = TaoPopover::VERSION
  spec.authors       = ["farthinker"]
  spec.email         = ["farthinker@gmail.com"]

  spec.summary       = %q{A popover component based on Tao Framework.}
  spec.description   = %q{A popover component based on Tao Framework.}
  spec.homepage      = "https://github.com/mycolorway/tao_popover"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "tao_on_rails", '~> 0.4.4'

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "blade", "~> 0.7.0"
  spec.add_development_dependency "blade-sauce_labs_plugin", "~> 0.6.2"
end
