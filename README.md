# Roshambo

An bot vs. bot roshambo dojo 

## Installation

Add this line to your application's Gemfile:

    gem 'roshambo'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install roshambo

## Usage

    % irb
    > require 'roshambo'
    > require '<your bot code>'
    > dojo = Roshambo::Dojo.new(Your::Bot::Class.new [, Other::Bot::Class.new])
    > dojo.fight

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
