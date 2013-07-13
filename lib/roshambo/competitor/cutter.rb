module Roshambo
  module Competitor
    class Cutter < Player
      def throw
        track_and_throw :scissors
      end
    end
  end
end