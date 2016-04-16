module Roshambo
  class ScoreCard
    attr_reader :competitor1, :competitor2, :wins_needed

    def initialize(competitor1, competitor2, wins_needed)
      @competitor1 = competitor1
      @competitor2 = competitor2
      @wins_needed  = wins_needed
      @card = [0, 0, 0]
    end

    def tally(winner)
      if winner == competitor1
        @card[0] += 1
      elsif winner == competitor2
        @card[1] += 1
      else # a draw
        @card[2] += 1
      end
    end

    def complete
      @card.max >= wins_needed
    end

    def winner
      if @card[0] > @card[1]
        competitor1
      elsif @card[1] > @card[0]
        competitor2
      end
    end
  end
end
