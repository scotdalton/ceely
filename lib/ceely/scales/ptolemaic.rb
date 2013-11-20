module Ceely
  module Scales
    module Ptolemaic
      # A Ptolemaic::Note is a Pythagorean Note
      # but tweaked
      class Note < Ceely::Scales::Pythagorean::Note

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
      end

      # A Ptolemaic::Scale is a Pythagorean::Scale
      # adjusted by Ptolemy for consonance.
      class Scale < Ceely::Scales::Pythagorean::Scale
        NOTE_NAMES = %w{ C Db D Eb E F F# G Ab A Bb B }
        NOTE_TYPES = %w{ 1 m2 2 m3 M3 4 b5 5 m6 M6 m7 M7 }

        def initialize(fundamental_frequency=528.0, *args)
          super(fundamental_frequency, 12, -5, NOTE_NAMES, NOTE_TYPES)
        end
      end
    end
  end
end
