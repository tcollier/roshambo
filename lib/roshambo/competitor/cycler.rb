module Roshambo
  module Competitor
    class Cycler < Player
      def reset!(seed)
        super
        rng = Random.new(seed)
        @index = rng.rand(3)
        @forward = rng.rand > 0.5
      end

      def throw
        track_and_throw next_throw
      end

      private

      def next_throw
        @index += (@forward ? 1 : 2)
        @index = @index % 3
        Match::VALID_THROWS[@index]
      end
    end
  end
end
