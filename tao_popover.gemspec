# coding: utf-8
$:.push File.expand_path("../lib", __FILE__)

require "tao_popover/version"

Gem::Specification.new do |spec|
  spec.name          = "tao_popover"
  spec.version       = TaoPopover::VERSION
  spec.authors       = ["farthinker"]
  spec.email         = ["farthinker@gmail.com"]

  spec.summary       = %q{An easy to use popover component for Rails.}
  spec.description   = %q{A popover component based on Tao Framework.}
  spec.homepage      = "https://github.com/mycolorway/tao_popover"
  spec.license       = "MIT"

  spec.files = Dir["{lib,vendor}/**/*", "LICENSE", "Rakefile", "README.md"]

  spec.add_runtime_dependency "tao_on_rails", '~> 0.8.1'
  spec.add_runtime_dependency "tao_ui", '~> 0.1.3'

  spec.add_development_dependency "sqlite3", '~> 1.3'
  spec.add_development_dependency "blade", "~> 0.7.0"
  spec.add_development_dependency "blade-sauce_labs_plugin", "~> 0.6.2"

end
