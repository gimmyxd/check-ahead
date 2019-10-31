# check-ahead ![badge](https://action-badges.now.sh/gimmyxd/check-ahead)

Helps you create consistent and transparent rules for checking commit messages.

## Rake Tasks

`check-ahead:commits` - checks the commits against defined rules

`check-ahead:generate_rules` - generate rules from input

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

The accepted content is defined between `<commits></commits>` tag and `<digits>` will be translated to the correspunding regex: `d+`.

Check [example CONTRIBUTING.md](spec/fixtures/CONTRIBUTING.md)

This will be used by `check-ahead:commits` which allows only commit messages that match `(PA-\d+|maint|docs)`


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
# usually in your Rakefile

require 'check-ahead'
CheckAhead.load_tasks # loads rake task on demand

# alternative loading
require 'check-ahead'
include CheckAhead # loads rake task on project initialization
```

## Configuration

The gem supports configuration for: commit_range, CONTRIBUTING.md path, base_tags

Example:

```ruby
CheckAhead.configure do |config|
  config.commit_range = 'master..HEAD'
  config.contributing_md = "/docs/CONTRIBUTING.md"
  config.base_tags = [revert]
  config.max_length = 100
  config.checking_max_length = true
end
```

or ENVIRONMENT variables:

```ruby
ENV['BASE_TAGS']
ENV['CONTRIBUTING_MD']
ENV['COMMIT_RANGE']
ENV['MAX_LENGTH']
ENV['CHECK_MAX_LENGTH']
```

Defaults:

```ruby
base_tags = %w[revert merge]
contributing_md = File.join('project_root/CONTRIBUTING.md')
commit_range = 'master..HEAD'
max_length = 50
check_max_length = false
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
