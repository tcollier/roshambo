module Roshambo
  class Dojo
    attr_reader :competitor1, :competitor2, :output
    attr_accessor :throws_to_win_match

    DEFAULT_MATCHES = 3
    DEFAULT_THROWS_PER_MATCH = 25

    def initialize(competitor1, competitor2 = Competitor.random, output = $stdout)
      @competitor1 = competitor1
      @competitor2 = competitor2
      @output      = output
    end

    def self.start_from_command_line_args(args)
      return usage if args.length == 0
      competitor1 = load_competitor(args[0]) || return
      if args.length > 1
        competitor2 = load_competitor(args[1]) || return
      else
        competitor2 = Roshambo::Competitor.random
      end
      new(competitor1, competitor2).fight
    end

    def self.usage
      puts "Usage: #{$0} <competitor1 class> [<competitor2 class>]"
      puts "example: #{$0} Roshambo::Competitor::SpazmanianDevil"
      puts "If competitor2 class is not given, a built-in competitor will be chosen at random:"
      puts ""
      puts "  * Roshambo::Competitor::Cycler - starts with random throw, then cycles through all throws on repeat"
      puts "  * Roshambo::Competitor::Cutter - always throws :scissors"
      puts "  * Roshambo::Competitor::PaperDoll - always throws :paper"
      puts "  * Roshambo::Competitor::Rocky - always throw :rock"
      puts "  * Roshambo::Competitor::SpazmanianDevil - chooses its throws randomly"
    end

    def self.load_competitor(class_name)
      competitor_class = const_get(class_name)
      competitor = competitor_class.new
      competitor_class.include(DefaultName) unless competitor.respond_to?(:name)
      competitor
    rescue NameError
      puts "Unrecognized class: #{class_name}, did you add it to the Gemfile and external competitors include?"
      puts ""
      puts "# Gemfile"
      puts "..."
      puts "gem '<your gem>', git: 'https://github.com/<your username>/<your gem>.git'"
      puts ""
      puts "# lib/roshambo/competitor/externals.rb"
      puts "require '<your gem>'"
      puts ""
      puts "Don't forget to run bundle"
    end

    def fight(matches = DEFAULT_MATCHES)
      score_card = ScoreCard.new(competitor1, competitor2, matches)
      matches.times do |index|
        match_num = index + 1
        winner = Match.new(competitor1, competitor2, output).fight(throws_to_win_match || DEFAULT_THROWS_PER_MATCH)
        score_card.tally winner
        print_match_winner(winner, match_num)
      end
      print_winner score_card.winner
    end

  private
    module DefaultName
      def name
        self.class.name
      end
    end
    private_constant :DefaultName

    def print_match_winner(winner, match_num)
      output.puts
      if winner
        output.puts "#{winner.name} won match #{match_num}"
      else
        output.puts "Match #{match_num} was a draw"
      end
      output.puts
    end

    def print_winner(winner)
      if winner
        output.puts "#{winner.name} beat #{([competitor1, competitor2] - [winner]).first.name}!!!"
      else
        output.puts "Bout was a draw"
      end
    end
  end
end
