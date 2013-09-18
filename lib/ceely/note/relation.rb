module Ceely
  module Note
    # A Relation is a Note::Base that takes a fundamental note, a relation number
    # an interval factor
    class Relation < Note::Base
      attr_reader :fundamental, :relation, :interval_factor
      alias :fundamental_ratio :interval_factor

      def initialize(fundamental, relation, interval_factor)
        @fundamental, @relation = fundamental, relation
        # Make the factor a ratio
        @interval_factor = Rational(interval_factor)
        super((fundamental.frequency * interval_factor).to_f)
      end

      # Intended to be overridden by subclasses
      def octave
        raise NotImplementedError.new("You should implement octave, Stretch.")
      end

      # Intended to be overridden by subclasses
      def octave_denominator
        raise NotImplementedError.new("You should implement octaved denominator, Slim.")
      end

      def octave_ratio
        @octave_ratio ||= Rational(interval_factor, octave_denominator)
      end

      def octave_frequency
        @octave_frequency ||= octave_ratio.to_f * fundamental.frequency
      end

      def to_s
        @s ||= clean %Q{
          Relation: #{relation}
          Fundamental Ratio: #{interval_factor}
          Fundamental Frequency: #{fundamental.frequency}
          Frequency: #{frequency}
        }
      end

      def clean(string)
        string.strip.gsub(/^\s*/, "\t")
      end
      protected :clean
    end
  end
end
