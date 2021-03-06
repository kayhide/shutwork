# Shutwork

[![Build Status](https://travis-ci.com/kayhide/shutwork.svg?branch=master)](https://travis-ci.com/kayhide/shutwork)
[![Gem Version](https://badge.fury.io/rb/shutwork.svg)](https://badge.fury.io/rb/shutwork)

## Installation

Install `shutwork` as:

    $ gem install shutwork

## Usage

### About me

To get me:

    $ shutwork me

For the first time, it will complain about the absense of token and tell you what to do.
Follow the displayed instruction and supply your token.

When token is prepared, `me` command will show your account id and your name.

    $ shutwork me
        123456  Alice

### List rooms and messages

To get rooms:

    $ shutwork rooms
      12000000  A room
      29000000  Bob
      47000000  Another room
     188000000  Yet anoter room
    ....

To get messages of a room:

    $ shutwork rooms 12000000
    ----------------
    2019-10-23 01:19:50 +0900  Alice
    Hey, it is working!
    ----------------
    2019-10-23 12:49:16 +0900  Bob
    Wow, unbelievable!
    ----------------
    ....

### List members and files

To list memebers at a room:

    $ shutwork rooms 12000000 --members
        123456  Alice
      29000000  Bob
    ...

To list files at a room:

    $ shutwork rooms 12000000 --files
    2016-08-30 16:12:31 +0900   544KB  help_me.jpg
    2016-09-02 12:26:26 +0900   229KB  maybe_broken.jpg
    2016-10-15 19:59:53 +0900   1.0MB  smoking_melting.jpg
    2016-11-23 21:52:26 +0900   253KB  seriously_damaged.jpg
    2017-01-28 16:05:37 +0900   204KB  rip.jpg
    ...

### Download files

To download files which is uploaded onto a room:

    $ shutwork rooms 12000000 --download
        download  download/12000000/file-1.jpg
        download  download/12000000/file-2.jpg
        download  download/12000000/file-3.jpg
        download  download/12000000/file-4.jpg
    ....

Then files are stored at `download/12000000` directory.

Optionally, you can specify the download directory as:

    $ shutwork rooms 12000000 --download --download-dir my/photos
        download  my/photos/12000000/file-1.jpg
        download  my/photos/12000000/file-2.jpg
        download  my/photos/12000000/file-3.jpg
        download  my/photos/12000000/file-4.jpg
    ....
    
And files are downloaded into `my/photos/12000000` directory.

### Note

Because of the limitation of Chatwork API, messages cannot be retrieved more than 100 items.

It only collects the most recent 100 messages.



## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kayhide/shutwork.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
