module Roshambo
  module Competitor
    class SpazmanianDevil < Player
      def throw
        track_and_throw Roshambo::Match::VALID_THROWS.sample
      end
    end
  end
end