require 'delegate'

module Roshambo
  module Competitor
    class History < SimpleDelegator
      class Round
        attr_accessor :mine, :theirs

        def initialize(mine = nil, theirs = nil)
          @mine   = mine
          @theirs = theirs
        end
      end

      attr_accessor :rounds

      def initialize
        super Array.new
      end

      def add(round)
        __getobj__ << round
      end

      def reset
         clear
      end
    end
  end
end