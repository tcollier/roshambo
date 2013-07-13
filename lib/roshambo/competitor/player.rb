module Roshambo
  module Competitor
    class Player
      attr_reader :seed, :history

      def initialize
        @history = History.new
      end

      def reset(seed)
        @seed = seed
        history.reset
      end

      def throw
        raise "Must implement in subclass"
      end

      def last_competitor_throw=(thrown)
        @current_round ||= History::Round.new
        @current_round.theirs = thrown
        history.add(@current_round)
        @current_round = nil
      end

      def name
        self.class.name.split('::').last
      end

    private
      def track_and_throw(thrown)
        @current_round = History::Round.new(thrown)
        thrown
      end
    end
  end
end