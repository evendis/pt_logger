# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pt_logger/version'

Gem::Specification.new do |spec|
  spec.name          = "pt_logger"
  spec.version       = PtLogger::VERSION
  spec.authors       = ["Paul Gallagher"]
  spec.email         = ["gallagher.paul@gmail.com"]
  spec.description   = %q{Simple way to log messages to Pivotal tracker stories}
  spec.summary       = %q{Provides a simple interface for logging infomation on a Pivotal Tracker story}
  spec.homepage      = "https://github.com/evendis/pt_logger"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency(%q<activesupport>, [">= 3.0.3"])
  spec.add_runtime_dependency(%q<pivotal-tracker>, [">= 0.5.10"])

  spec.add_development_dependency(%q<bundler>, ["> 1.1.0"])
  spec.add_development_dependency(%q<rake>, ["~> 0.9.2.2"])
  spec.add_development_dependency(%q<rspec>, ["~> 2.8.0"])
  spec.add_development_dependency(%q<rdoc>, ["~> 3.11"])
  spec.add_development_dependency(%q<guard-rspec>, ["~> 1.2.0"])
  spec.add_development_dependency(%q<rb-fsevent>, ["~> 0.9.1"])
  spec.add_development_dependency(%q<vcr>, ["~> 2.4"])
  spec.add_development_dependency(%q<webmock>, ["~> 1.9.0"])

end
