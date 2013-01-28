# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "ios-sim-test/version"

Gem::Specification.new do |s|
  s.name        = "ios-sim-test"
  s.version     = IOSSimTest::VERSION
  s.authors     = ["Eloy Durán"]
  s.email       = ["eloy.de.enige@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "ios-sim-test"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "bacon"
  s.add_development_dependency "mocha"
  s.add_development_dependency "mocha-on-bacon"
end
