# UsBankHolidays

https://github.com/albertosaurus/us_bank_holidays

[![Build Status](https://travis-ci.org/albertosaurus/us_bank_holidays.png?branch=master)](https://travis-ci.org/albertosaurus/us_bank_holidays)
[![Code Climate](https://codeclimate.com/github/albertosaurus/us_bank_holidays.png)](https://codeclimate.com/github/albertosaurus/us_bank_holidays)
[![Gem Version](https://badge.fury.io/rb/us_bank_holidays.png)](http://badge.fury.io/rb/us_bank_holidays)

Patches `Date` to make working with US bank holidays easier

## Requirements

Tested against the following Ruby runtimes:

* MRI 2.3, 2.4, 2.5
* JRuby 9 
* Rubinius (latest)

## Installation

Add this line to your application's Gemfile:

    gem 'us_bank_holidays'

And then execute:

    $ bundle install

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
date.banking_day?                         # Returns true
date.first_banking_day_of_month?          # Returns false
date.last_banking_day_of_month?           # Returns false

Date.new(2014, 1, 16).add_banking_days(2) # Returns Tuesday, January 21, 2014
Date.new(2014, 1, 5).previous_banking_day # Returns Friday, January 3, 2014
```

By default, weekends always count as bank holidays, but this can be disabled.

```ruby
date = Date.new(2014, 2, 2)               # Sunday, February 2, 2014
date.bank_holiday?                        # Returns true
date.bank_holiday?(false)                 # Returns false
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Make sure all your changes are covered by tests
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request
