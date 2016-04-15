module Roshambo
  module Competitor
    class SpazmanianDevil < Player
      def reset!(seed)
        @rng = Random.new(seed)
      end

      def throw
        track_and_throw Roshambo::Match::VALID_THROWS[@rng.rand(3)]
      end
    end
  end
end
