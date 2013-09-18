module Ceely
  module Note
    # A Note::Harmonic is a Note::Relation with the interval factor equal 
    # to the relation number
    class Harmonic < Note::Relation
      alias :degree :relation

      def initialize(fundamental, relation)
        # Interval factor is the number of the relation
        interval_factor = relation
        super(fundamental, relation, interval_factor)
      end

      def octave
        @octave ||= Math.log2(relation).to_i + 1
      end

      def octave_denominator
        @octave_denominator ||= 2**(octave - 1)
      end

      def to_s
        @s ||= clean %Q{
          Degree: #{degree}
          Fundamental Ratio: #{fundamental_ratio}
          Fundamental Frequency: #{fundamental.frequency}
          Frequency: #{frequency}
          Octave: #{octave}
          Octave Denominator: #{octave_denominator}
          Octave Ratio: #{octave_ratio}
          Octave Frequency: #{octave_frequency}
        }
      end
    end
  end
end
