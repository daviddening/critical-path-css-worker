# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "critical_path_css_worker/version"

Gem::Specification.new do |spec|
  spec.name          = "critical-path-css-worker"
  spec.version       = CriticalPathCssWorker::VERSION
  spec.authors       = ["David Dening"]
  spec.email         = ["daviddening@gmail.com"]

  spec.summary       = %q{A wrapper of the critical-path-css-rails gem that handles critical css generation and caching.}
  spec.description   = %q{A wrapper of the critical-path-css-rails gem that handles critical css generation and caching.}
  spec.homepage      = "https://github.com/daviddening"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
