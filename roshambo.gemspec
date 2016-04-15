# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'roshambo/version'

Gem::Specification.new do |gem|
  gem.name          = "roshambo"
  gem.version       = Roshambo::VERSION
  gem.authors       = ["tcollier"]
  gem.email         = ["tcollier@gmail.com"]
  gem.description   = %q{A Roshambo dojo with some default players}
  gem.summary       = %q{A Roshambo dojo with some default players}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency 'pry-byebug', '~> 3.3'
end
