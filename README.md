# PtLogger [![Build Status](https://secure.travis-ci.org/evendis/pt_logger.png?branch=master)](http://travis-ci.org/evendis/pt_logger)

PtLogger is a simple way to log messages to Pivotal tracker stories.

The main motivation for this is for situations where you may be facing an as-yet unreproduceable
bug issue and you want to collection more specific information, possibly even from production environments.

What you might do is add some special instrumentation and logging. But instead of having to go check the
log files every so often, wouldn't it be nice if the information you are collecting gets automatically added
to the related Pivotal Tracker story you are working on?

That's what PtLogger is for.

## Installation

Add this line to your application's Gemfile:

    gem 'pt_logger'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pt_logger

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## How to run tests

Test are implemented using rspec. Run tests with <tt>rake</tt> or <tt>rake spec</tt>.

[Guard](https://rubygems.org/gems/guard) is installed as part of the development dependencies,
so to start continuous test execution on file change, start it up with <tt>bundle exec guard</tt>.

# The PtLogger Cookbook

## How to configure PtLogger

Configuration is done using a setup block. In a Rails application, you would normally do this in
and initializer e.g. config/initializers/pt_logger.rb

    PtLogger.setup do |config|
      config.api_key = 'xxxxx'
      config.project_id = 'yyyyy'
    end

The API Key and PT project settings are global in nature. It is explicity assumed that all logging
within the project should be done with a single API Key and to the same project.

NB: there currently isn't a generator to make a config file for you

## How to log a message with explicit story ID parameter

    message_text = "this is whatever you want to log. It must be a string or support a :to_s method"
    story_id = "1234"
    PtLogger.log(message_text,story_id)

## How to log a message with implicit story ID

If the PT story ID is not passed as an explicit parameter to the <tt>log</tt> method,
PtLogger will attempt to find a story ID in the message text itself.
The story ID may either be prefixed with "#" or "PT:", for example:

    PtLogger.log("logging a message to PT:123456 (i.e. this will be added to Pivotal Tracker story number 123456)")
    PtLogger.log("alternatively #78910 (i.e. this will be added to Pivotal Tracker story number 78910)")
