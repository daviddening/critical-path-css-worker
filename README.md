# Critical::Path::Css::Worker

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/critical/path/css/worker`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'critical-path-css-worker'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install critical-path-css-worker

## Usage

This gem depends on the loadcss-rails gem.  Per their instructions.

The loadCSS and onloadCSS files will be added to the asset pipeline and available for you to use. Add the lines that you need to your application's JS manifest (usually app/assets/javascripts/application.js).

```
//= require loadCSS
//= require cssrelpreload
//= require onloadCSS
```

Setup critical_path_css.yml per the critical_path_css README

[https://github.com/mudbugmedia/critical-path-css-rails]

### Before deployment

Make sure analytics ignore the Penthouse headless browser used to generate the css

'Penthouse Critical Path CSS Generator'


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/critical-path-css-worker. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Critical::Path::Css::Worker project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/critical-path-css-worker/blob/master/CODE_OF_CONDUCT.md).
