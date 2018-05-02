# DataHoover

This gem exposes a simple API to implement event sourcing in your app.
It comes by default with a [Segment](https://segment.com/) adapter but you
could very well inject your own (be it [Kafka](https://kafka.apache.org/) or
anything you can come up with).

Please refer to `lib/data_hoover/bags/segment_analytics.rb` for an example.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'data-hoover'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install data-hoover

## Configuration

First, you have to setup the gem a little bit:

``` ruby
DataHoover.logger = Logger.new(STDOUT)
DataHoover.traits = ->(user) { ... }
```

If you want to silence the logging, just pass in `Logger.new(nil)`.

The traits lambda is used to properly qualify your users. If you do not need
this, you can skip the configuration, as a default lambda is setup by the gem
(spoiler: it does nothing!).

We also provide you with a helper method if you want to anonymize your data:

``` ruby
DataHoover.anonymize(...)

# DataHoover.anonymize(nil) => nil
# DataHoover.anonymize('foo') => Digest::SHA256.hexdigest('foo')
# DataHoover.anonymize(1) => Digest::SHA256.hexdigest(1.to_s)
```

In a Rails environment, you might want to put this snippet in an
[initializer](http://guides.rubyonrails.org/configuring.html#using-initializer-files).

If you want to be able to use the provided Segment adapter, you will need to
setup an env variable with your API key:

``` ruby
ENV['SEGMENT_KEY'] = 'YOUR_SEGMENT_KEY'
```

## Usage

To instantiate the client, run:
``` ruby
DataHoover::Nozzle.new(trackee: trackee)
```

You can additionally provide your own adapter here:
```
nozzle = DataHoover::Nozzle.new(trackee: trackee, bag: CustomKafkaAdapter)
```

And you can then start to send events:
``` ruby
event_payload = {
  field_1: 'foo',
  field_2: { bar: 'baz' }
}
nozzle.absorb('event_name', event_payload)
```

If you are using [RSpec](https://github.com/rspec/rspec-core), you can `require
data_hoover/rspec/matchers` in your spec file. This will let you do things like
``` ruby
it { expect(subject).to track(event_name).with(event_payload) }
```
in your test files (make sure your subject responds to `#call`).
If your subject does not respond to call, you can also go with the block
version:
``` ruby
expect { subject }.to track(event_name).with(event_payload) }
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/jobteaser/data-hoover.


## License

The gem is available as open source under the terms of the
[MIT License](http://opensource.org/licenses/MIT).

## TODO

- [ ] Expose a mean to choose the anonymization implementation (and use it
  internally as well)
