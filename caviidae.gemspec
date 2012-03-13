# -*- encoding: utf-8 -*-
require File.expand_path('../lib/caviidae/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Eric J. Holmes"]
  gem.email         = ["eric@ejholmes.net"]
  gem.description   = %q{Gem to help with integration testing of visualforce apps with capybara}
  gem.summary       = %q{Gem to help with integration testing of visualforce apps with capybara}
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "caviidae"
  gem.require_paths = ["lib"]
  gem.version       = Caviidae::VERSION

  gem.add_dependency "capybara"
  gem.add_dependency "databasedotcom", "1.3.0"

  gem.add_development_dependency "rspec"
end
