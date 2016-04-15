# Roshambo

A bot vs. bot roshambo dojo

## Usage

```bash
cd /tmp
git clone git@github.com:tcollier/roshambo.git
cd roshambo
```

Now add your bot gem to Gemfile (see the example roshambot gem)

```ruby
# Gemfile
gem '<gem name>', git: 'https://github.com/<username>/<gem name>.git'
```

And include the code in the externals include file

```ruby
# lib/roshambo/competitor/externals.rb
require '<gem name>'
```

Now we're ready to ruuuuuummmmmmmbblllleeee
```bash
bundle
./bin/roshambo <your bot class>
# e.g.
# ./bin/roshambo Roshambot::Tominator
#
# Alternatively you can specify a second competitor
# ./bin/roshambo Roshambot::Tominator Roshambo::Competitor::SpazmanianDevil
```

## Create your own bot

A bot must respond to three different method calls

1. `reset!(seed)`  - called before the match starts, seed is a random number
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

## Built-in bots

There are several built-in bots for testing purposes

* `Roshambo::Competitor::Cycler` - starts with random throw, then cycles through all throws on repeat
* `Roshambo::Competitor::Cutter` - always throws `:scissors`
* `Roshambo::Competitor::PaperDoll` - always throws `:paper`
* `Roshambo::Competitor::Rocky` - always throw `:rock`
* `Roshambo::Competitor::SpazmanianDevil` - chooses its throws randomly


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
