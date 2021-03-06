# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "ios-sim-test/version"

Gem::Specification.new do |s|
  s.name        = "ios-sim-test"
  s.version     = IOSSimTest::VERSION
  s.authors     = ["Eloy Durán"]
  s.email       = ["eloy.de.enige@gmail.com"]
  s.homepage    = "https://github.com/alloy/ios-sim-test"
  s.summary     = "A command-line test runner for your iOS SenTest tests."

  s.rubyforge_project = "ios-sim-test"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "claide", ">= 0.2"
  s.add_dependency "colored", "~> 1.2"

  s.add_development_dependency "bacon"
  s.add_development_dependency "mocha"
  s.add_development_dependency "mocha-on-bacon"
end
