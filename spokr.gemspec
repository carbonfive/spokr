# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "spokr/version"

Gem::Specification.new do |s|
  s.name        = "spokr"
  s.version     = Spokr::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jared Carroll", "Rob Pak"]
  s.email       = ["jared@carbonfive.com", "rob@carbonfive.com"]
  s.homepage    = "http://github.com/carbonfive/spokr"
  s.summary     = %q{Ruby client for Spoke API}
  s.description = %q{}

  s.rubyforge_project = "spokr"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.add_development_dependency 'rspec'
end
