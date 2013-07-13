module Roshambo
  module Competitor
    class Rocky < Player
      def throw
        track_and_throw :rock
      end
    end
  end
end