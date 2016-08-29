lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bojack/version'

Gem::Specification.new do |spec|
  spec.name          = "bojack"
  spec.version       = Bojack::VERSION
  spec.authors       = ["Hugo Abonizio"]
  spec.email         = ["hugo_abonizio@hotmail.com"]

  spec.summary       = %q{BoJack client for Ruby.}
  spec.description   = %q{BoJack client for Ruby.}
  spec.homepage      = "https://github.com/hugoabonizio/bojack.rb"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
