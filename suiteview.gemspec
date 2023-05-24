Gem::Specification.new do |s|
  s.name        = "suiteview"
  s.version     = "1.0.0"
  s.summary     = "suiteview is a tool to help you get a big picture view of what is in your cucumber suite"
  s.description = "suiteview is a tool to help show the contents of a cucumber suite with your unique specifications"
  s.authors     = ["David West"]
  s.email       = "support@suiteview.xyz"
  s.files       = ["lib/suiteview.rb"]
  s.homepage    =
    "https://rubygems.org/gems/suiteview"
  s.metadata = { "github_repo" => "ssh://github.com/suiteview/suiteview" }
  s.license       = "MIT"

  s.add_development_dependency "rspec", "~> 3.5"
  s.add_development_dependency "rubycritic", "~> 2.9"

  s.add_runtime_dependency "cql", "~> 1.7"
end
