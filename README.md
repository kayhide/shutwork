# Shutwork

[![Build Status](https://travis-ci.com/kayhide/shutwork.svg?branch=master)](https://travis-ci.com/kayhide/shutwork)
[![Gem Version](https://badge.fury.io/rb/shutwork.svg)](https://badge.fury.io/rb/shutwork)

## Installation

Install `shutwork` as:

    $ gem install shutwork

## Usage

To get me:

    $ shutwork me

For the first time, it will complain about the absense of token and tell you what to do.
Follow the displayed instruction and supply your token.

When token is prepared, `me` command will show your account id and your name.

    $ shutwork me
        123456  Alice

To get rooms:

    $ shutwork rooms
      12000000  A room
      29000000  Bob
      47000000  Another room
     188000000  Yet anoter room
    ....

To get messages of a room:

    $ shutwork 12000000
    ----------------
    2019-10-23 01:19:50 +0900  Alice
    Hey, it is working!
    ----------------
    2019-10-23 12:49:16 +0900  Bob
    Wow, unbelievable!
    ----------------
    ....


### Note

Because of the limitation of Chatwork API, messages cannot retrieved more than 100 items.

It only collects the most recent 100 messages.



## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kayhide/shutwork.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
