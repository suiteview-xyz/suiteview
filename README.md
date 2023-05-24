# Quickstart

## Install the gem
In your Gemfile
```Gemfile
source "https://rubygems.org"

gem "suiteview", "~> 1.0.0"
```

`$ bundle install`

## Use the gem

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