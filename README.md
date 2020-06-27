# DateRangeRollout

Gradual transition from one value to another between two dates.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'date_range_rollout'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install date_range_rollout

## Usage

Example: Get the percentage of time elapsed in the year:
```ruby
start_value = 0
start_date = Time.parse("2020-01-01")
end_value = 100
end_date = Time.parse("2020-12-31")

DateRangeRollout.build(start_value, start_date, end_value, end_date).get
```

Example: Slowly increase the numbers of jobs per day over the course of a month.
Imagine this class being run every day. This will perform 100 (`start_value`)
jobs until `start_date`, slowly increase the number until `end_date`, and stay
at 500 (`end_value`) after that date.
Since `get` returns a float, we want to round that value to the nearest integer.
```ruby
class SomeWorker
  def perform
    start_value = 100
    start_date = Time.parse("2020-02-17")
    end_value = 500
    end_date = Time.parse("2020-03-17")

    jobs_count = DateRangeRollout.build(start_value, start_date, end_value, end_date).get

    jobs_count.round.times do
      JobClass.do_something
    end
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/netlify/date_range_rollout.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
