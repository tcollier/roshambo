require 'timeout'

module Roshambo
  class Match
    attr_reader :competitor1, :competitor2, :output

    VALID_THROWS = [:rock, :paper, :scissors]
    MAX_TIME_TO_TRHOW = 0.01

    def initialize(competitor1, competitor2, output)
      @competitor1 = competitor1
      @competitor2 = competitor2
      @output = output
      seed = rand
      competitor1.reset(seed)
      competitor2.reset(seed)
    end

    def fight(num_throws_to_win)
      print_header
      score_card = ScoreCard.new(competitor1, competitor2, num_throws_to_win)
      while !score_card.complete
        score_card.tally execute_throw
      end
      score_card.winner
    end

  private
    def execute_throw
      throw1 = get_throw(competitor1)
      throw2 = get_throw(competitor2)
      competitor1.last_competitor_throw = throw2
      competitor2.last_competitor_throw = throw1
      winner = determine_winner(throw1, throw2)
      output.printf(" #{winner == competitor1 ? '*' : ' '}%-#{left_col_width}s  | #{winner == competitor2 ? '*' : ' '}%-#{right_col_width}s \n", throw1, throw2)
      winner
    end

    def get_throw(competitor)
      Timeout::timeout(MAX_TIME_TO_TRHOW) do
        competitor.throw
      end
    rescue
      nil
    end

    def determine_winner(throw1, throw2)
      if VALID_THROWS.include?(throw1) && VALID_THROWS.include?(throw2)
        if (throw1 == :rock && throw2 == :scissors) || (throw1 == :scissors && throw2 == :paper) || (throw1 == :paper && throw2 == :rock)
          competitor1
        elsif (throw1 == :scissors && throw2 == :rock) || (throw1 == :paper && throw2 == :scissors) || (throw1 == :rock && throw2 == :paper)
          competitor2
        end
      elsif VALID_THROWS.include?(throw1)
        competitor1
      elsif VALID_THROWS.include?(throw2)
        competitor2
      end
    end

    def print_header
      output.printf("  %-#{left_col_width}s  |  %-#{right_col_width}s  \n#{'-' * (left_col_width + 4)}+#{'-' * (right_col_width + 4)}\n", competitor1.name, competitor2.name)
    end

    def left_col_width
      (VALID_THROWS.map(&:to_s).map(&:length) + [competitor1.name.length]).max
    end

    def right_col_width
      (VALID_THROWS.map(&:to_s).map(&:length) + [competitor2.name.length]).max
    end
  end
end
