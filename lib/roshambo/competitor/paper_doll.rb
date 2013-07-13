module Roshambo
  module Competitor
    class PaperDoll < Player
      def throw
        track_and_throw :paper
      end
    end
  end
end