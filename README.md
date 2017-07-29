# DocusignDtr
This library is designed to help ruby applications consume the Docusign DTR API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'docusign_dtr'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install docusign_dtr

## Usage

```ruby
integrator_key = 'TRUST_NO_ONE'
secret_key = 'TRUST_NO_ONE'
redirect_url = 'https://www.google.ca'
ds = DocusignDtr::Auth.new(integrator_key: integrator_key, secret_key: secret_key, redirect_uri: redirect_url)
ds.auth_uri.to_s
# "https://account-d.docusign.com/oauth/auth?response_type=code&scope=signature&client_id=TRUST_NO_ONEstate=TRUST_NO_ONE&redirect_uri=https%3A%2F%2Fwww.google.ca"
```ruby

Send your client to the auth_uri above and they will be redirected to the redirect_url  (for now its google.ca)

```ruby
url='https://www.google.ca/?code=TRUST_NO_ONE&state=TRUST_NO_ONE'
parsed_url = ds.parse_url_response(url)
token = ds.get_token(response_code: parsed_url.code, state: parsed_url.state).access_token
api = DocusignDtr::Client.new(token: token)
offices = api.Office.all
```

:TODO:

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/docusign_dtr.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
