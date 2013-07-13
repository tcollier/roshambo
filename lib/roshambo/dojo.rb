module Roshambo
  class Dojo
    attr_reader :competitor1, :competitor2, :output
    attr_accessor :throws_to_win_match

    DEFAULT_MATCHES_TO_WIN      = 3
    DEFAULT_THROWS_TO_WIN_MATCH = 9

    def initialize(competitor1, competitor2 = Competitor.random, output = $stdout)
      @competitor1 = competitor1
      @competitor2 = competitor2
      @output      = output
    end

    def self.from_command_line_args(args)
      competitor1 = args.length > 0 ? Roshambo::Competitor.class_from_string(args[0]) : Roshambo::Competitor.random
      competitor2 = args.length > 1 ? Roshambo::Competitor.class_from_string(args[1]) : Roshambo::Competitor.random
      new(competitor1, competitor2)
    end

    def fight(matches_to_win = DEFAULT_MATCHES_TO_WIN)
      score_card = ScoreCard.new(competitor1, competitor2, matches_to_win)
      match_num = 1
      while !score_card.complete
        winner = Match.new(competitor1, competitor2, output).fight(throws_to_win_match || DEFAULT_THROWS_TO_WIN_MATCH)
        score_card.tally winner
        print_match_winner(winner, match_num)
        match_num += 1
      end
      print_winner score_card.winner
    end

  private
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
