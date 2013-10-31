module Ceely
  module Ptolemaic
    # A Ptolemaic::Note is a Pythagorean Note
    # but tweaked
    class Note < Ceely::Pythagorean::Note
      def octave_adjusted_factor
        @octave_adjusted_factor ||= case index
          when -5, -4, -3
            syntonic_comma * super
          when 3, 4, 5
            (1/syntonic_comma) * super
          when 6
            diminished_fifth_factor
          else 
            super
          end
      end

      def diminished_fifth_factor
        return @diminished_fifth_factor if defined? @diminished_fifth_factor
        pythagorean_f = pythagorean.note_by_name("F")
        harmonic_b = harmonic.note_by_name("B")
        @diminished_fifth_factor = harmonic_b.interval(pythagorean_f ) * 2
      end

      def syntonic_comma
        return @syntonic_comma if defined? @syntonic_comma
        harmonic_third = harmonic.note_by_type("M3")
        pythagorean_third = pythagorean.note_by_type("M3")
        @syntonic_comma = harmonic_third.interval(pythagorean_third)
      end

      def harmonic
        @harmonic ||= Ceely::Harmonic::Scale.new
      end

      def pythagorean
        @pythgorean ||= Ceely::Pythagorean::Scale.new
      end
    end

    # A Ptolemaic::Scale is a Pythagorean::Scale
    # adjusted by Ptolemy for consonance.
    class Scale < Ceely::Pythagorean::Scale
      NOTE_NAMES = %w{ C Db D Eb E F F# G Ab A Bb B }

      def initialize(fundamental_frequency=528.0, *args)
        super(fundamental_frequency, 12, -5, NOTE_NAMES)
      end
    end
  end
end
