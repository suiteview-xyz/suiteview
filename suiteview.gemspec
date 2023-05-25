Gem::Specification.new do |s|
  s.name        = "suiteview"
  s.version     = "2.1.41"
  s.summary     = "suiteview is a tool to help you get a big picture view of what is in your cucumber suite"
  s.description = <<-DESC
suiteview is a tool to help show the contents of a cucumber suite with your unique specifications

`my_suiteview.rb`

```ruby
require "suiteview"

# Instantiate the SuiteView class and give it the location of your Cucumber Suite (repo)
sv = SuiteView.new({repo: "features", include_tags: "@tweets,@followers"})

# Get a count of all Scenarios directly tagged with a particular tag
sv.percentages.to_csv.render_to_file("my.csv")
```

And you'll have your output

`my.csv`

```csv
tag,percent
@tweets,80.0
@followers,20.0
```

`my_suiteview2.rb`

```ruby
require "suiteview"

# Instantiate the SuiteView class and give it the location of your Cucumber Suite (repo)
sv = SuiteView.new({repo: "features", include_tags: "@tweets,@followers"})

# Get a count of all Scenarios directly tagged with a particular tag
sv.total_tags_count.to_csv.render_to_file("my2.csv")
```

`my2.csv`

```csv
tag,count
@tweets,4
@followers,1
```
DESC
  s.authors     = ["David West"]
  s.email       = "support@suiteview.xyz"
  s.files       = ["lib/suiteview.rb"]
  s.homepage    =
    "https://github.com/suiteview/suiteview"
  s.metadata = { "github_repo" => "ssh://github.com/suiteview/suiteview" }
  s.license       = "MIT"

  s.add_development_dependency "rspec", "~> 3.5"
  s.add_development_dependency "rubycritic", "~> 2.9"

  s.add_runtime_dependency "cql", "~> 1.7"
  s.add_runtime_dependency "csv", "~> 3.0"
end
