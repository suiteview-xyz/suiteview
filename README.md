# Quickstart

## Install the gem
In your Gemfile
```Gemfile
source "https://rubygems.org"

gem "suiteview", "~> 3.0.0"
```

`$ bundle install`

## Use the gem

### See a cool piechart

`make_me_a_pie.rb`

```ruby
require 'suiteview'

SuiteView.new({ repo: repo, include_tags: '@tweets,@followers' }).total_tags_count.to_csv.render_pie_chart_html("#{__dir__}/my_pie.html").launch
```

`my_suiteview.rb`

```ruby
require "suiteview"

# Instantiate the SuiteView class and give it the location of your Cucumber Suite (repo)
sv = SuiteView.new({repo: "features", include_tags: "@tweets,@followers", exclude_tag: "@wip"})

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
sv = SuiteView.new({repo: "features", include_tags: "@tweets,@followers", exclude_tag: "@wip"})

# Get a count of all Scenarios directly tagged with a particular tag
sv.total_tags_count.to_csv.render_to_file("my2.csv")
```

`my2.csv`

```csv
tag,count
@tweets,4
@followers,1
```