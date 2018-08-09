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
auth = DocusignDtr::Auth::Jwt.new(
  integrator_key: '1e1e1e1e-1e1e-1e1e-1e1e-1e1e1e1e1e1e',
  private_key: "-----BEGIN RSA PRIVATE KEY-----\nTRUST_NO_ONE\n-----END RSA PRIVATE KEY-----",
  user_guid: user_guid = '1f1f1f1f-1f1f-1f1f-1f1f-1f1f1f1f1f1f',
  redirect_uri: 'https://www.google.com'
)
begin
auth.request_token
rescue DocusignDtr::ConsentRequired
  # launch or redirect user to grant url and try again
  Launchy.open(auth.grant_url)
end

puts "Your access token is #{auth.access_token}"
```

When you receive a DocusignDtr::ConsentRequired error Send your client to the grant_uril above and they will be required to authenticat your app. Once they authorize your app they will be redirected to the redirect_url  (for now its google.com)
When you receive an auth object you can use the access_token to connect to resources:

```ruby
auth_token = 'SOME_LONG_SECRET_TRUST_NO_ONE_WITH_THIS'
client = DocusignDtr::Client.new(token: auth_token, test_mode: false, application: 'myapplication.com')
all_rooms = client.Room.all
room =client.Room.find(all_rooms.last.id)
document = room.documents.last
file = document.download

# Other endpoints
offices = client.Office.all
document = client.Document.find(12345)
member = client.Member.find(56789)
task_list = client.TaskList.find(98765)
titles = client.Title.all
profile = client.User.profile(54321)
```

Now you can use the ```access_token``` in the docusign [api explorer](https://stage.cartavi.com/restapi/swashbuckle/ui/index).

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/docusign_dtr.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
