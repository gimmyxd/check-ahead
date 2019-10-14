# check-ahead
Helps you create consistent and transparent rules for accepting contributions to your open source projects.

## Rake Tasks
`check-ahead:commits` - checks the commits against defined rules
`check-ahead:generate_requirements` - generate rules from input

##<line>

**check-ahead** uses your **CONTRIBUTING.md** file

```
### Commit Message
Accepted commits messages:
<commits>

* PA-\<digits>
* maint
* docs
</commits>
```

This will generate a task `check-ahead:commits` which will allow only commit messages that match `(PA-\d+|maint|docs)`

##<line>


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'check-ahead'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install check-ahead

## Usage

```ruby
# Rakefile

require 'check-ahead'
CheckAhead.load_tasks
```

## Configuration

The gem supports configuration for: commit_range, CONTRIBUTING.md path, base_tags

Example:

```ruby
CheckAhead.configure do |config|
  config.commit_range = 'master..HEAD'
  config.contributing_md = "/docs/CONTRIBUTING.md"
  config.base_tags = [revert]
end
```

or ENVIRONMENT variables:

```ruby
ENV['BASE_TAGS']
ENV['CONTRIBUTING_MD']
ENV['COMMIT_RANGE']
```

Defaults:

```ruby
base_tags = %w[revert merge packaging]
contributing_md = File.join(/project_root/CONTRIBUTING.md')
commit_range = 'master..HEAD'
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/gimmyxd/check-ahead. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the CheckAhead project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/gimmyxd/check-ahead/blob/master/CODE_OF_CONDUCT.md).
