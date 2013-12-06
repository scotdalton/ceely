module Ceely
  module Scales
    module Meantone
      # A Meantone::Note is a Dodecaphonic::Note
      class Note < Ceely::Scales::Dodecaphonic::Note

        def octave_adjusted_factor
          super * ((1/syntonic_comma)**(index/dodecaphonic_m3.index))
        end

        def dodecaphonic_m3
          @dodecaphonic_m3 ||= dodecaphonic_scale.note_by_type("M3")
        end

        def dodecaphonic_scale
          @dodecaphonic_scale ||= 
            Ceely::Scales::Dodecaphonic::Scale.new(fundamental_frequency)
        end
      end

      # A Meantone::Scale is a Pythagorean::Scale but tweaked.
      class Scale < Pythagorean::Scale
        NOTE_NAMES = %w{ C C# Db D D# Eb E F F# Gb G G# Ab A A# Bb B }
        NOTE_TYPES = ["1", nil, nil, "2", nil, nil, "M3", "4", nil, nil, "5",
          nil, nil, "M6", nil, nil, "M7"]

        def initialize(fundamental_frequency=528.0, *args)
          super(fundamental_frequency, 17, -6, NOTE_NAMES, NOTE_TYPES)
        end
      end
    end
  end
end
