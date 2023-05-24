# Quickstart

## Install the gem
In your Gemfile
```Gemfile
source "https://rubygems.org"

gem "suiteview", "~> 1.0.0"
```

`$ bundle install`

## Use the gem

`my_ruby`

```ruby
require "suiteview"

# Instantiate the SuiteView class and give it the location of your Cucumber Suite (repo)
sv = SuiteView.new({repo: "features"})

# Get a count of all Scenarios directly tagged with a particular tag
puts sv.scenario_tag_count("@tweets")

# Get a count of all Scenario Outlines directly tagged with a particular tag
puts sv.outline_tag_count("@tweets")
```