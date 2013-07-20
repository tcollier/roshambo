# Roshambo

An bot vs. bot roshambo dojo 

## Installation

Add this line to your application's Gemfile:

    gem 'roshambo', :git => "git@github.com:tcollier/roshambo.git"

And then execute:

    $ bundle

## Usage

    % irb
    > require 'roshambo'
    > require '<your bot code>'
    > dojo = Roshambo::Dojo.new(Your::Bot::Class.new [, Other::Bot::Class.new])
    > dojo.fight

## Create your own bot

A bot must respond to three different method calls

1. `reset(seed)`  - called before the match starts, seed is a random number
between 0 and 1
2. `throw` - must return one of: :rock, :paper, :scissors. This method call
will be interrupted if it takes longer than
`Roshabo::Match::MAX_TIME_TO_TRHOW` seconds
3. `last_competitor_throw=(thrown)` - the symbol thrown by your opponent in
this round

You can inspect `Roshabo::Match#execute_throw` for more details on how these
methods are invoked.

Your bot class can also inherit from `Roshabo::Competitor::Player` and just
implement `throw`. By doing this, the match history is maintained for you if
you want to access it for decision making purposes.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
