module Roshambo
  module Competitor
    def self.random
      [Cutter, Cycler, PaperDoll, SpazmanianDevil, Rocky].sample.new
    end

    def self.class_from_string(str)
      Roshambo::Competitor.const_get(str).new
    rescue
      Kernel.const_get(str).new
    end
  end
end
