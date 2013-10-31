module Ceely
  module Dodecaphonic
    # A Dodecaphonic::Note is a Pythagorean Note
    class Note < Ceely::Pythagorean::Note
    end

    # A Dodecaphonic::Scale is a Pythagorean::Scale
    # with an offset of -6
    class Scale < Ceely::Pythagorean::Scale
      NOTE_NAMES = %w{ C Db D Eb E F Gb F# G Ab A Bb B }

      def initialize(fundamental_frequency=528.0, *args)
        super(fundamental_frequency, 13, -6, NOTE_NAMES)
      end

      def circle_of_fifths
        super("F#")
      end
    end
  end
end
