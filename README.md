# UsBankHolidays

Patches `Date` to make working with US bank holidays easier

## Installation

Add this line to your application's Gemfile:

    gem 'us_bank_holidays'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install us_bank_holidays

## Usage

First, load the gem.

```ruby
require 'us_bank_holidays'
```

This adds the following features to dates.

```ruby
date = Date.new(2014, 1, 3)               # Friday, January 3, 2014
date.bank_holiday?                        # Returns false
date.weekend?                             # Returns false
date.next_banking_day                     # Returns Monday, January 6, 2014

Date.new(2014, 1, 16).add_banking_days(2) # Returns Tuesday, January 21, 2014
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Make sure all your changes are covered by tests
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request
