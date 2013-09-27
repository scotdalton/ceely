module Ceely
  module Pythagorean
    # A Pythagorean is an Note with the factor equal to 3/2
    class Note < Ceely::Note

      # A pythagorean note has a factor equal to 3/2
      # raised to the power of the index
      def factor
        @factor ||= Rational(3, 2)**index
      end
    end

    # A Pythagorean::Scale is a Scale with a set Pythagorean::Notes
    class Scale < Ceely::Scale
      NOTE_NAMES = %w{ C D E F G A B }
      
      def initialize(fundamental_frequency=528.0, size=7, offset=-1, note_names=NOTE_NAMES)
        super(fundamental_frequency, size, offset, note_names)
      end

      # Return the ionian mode for the given octave
      def ionian(octave=0)
        mode(0, octave)
      end

      # Return the dorian mode for the given octave
      def dorian(octave=0)
        mode(1, octave)
      end

      # Return the phrygian mode for the given octave
      def phrygian(octave=0)
        mode(2, octave)
      end

      # Return the lydian mode for the given octave
      def lydian(octave=0)
        mode(3, octave)
      end

      # Return the mixolydian mode for the given octave
      def mixolydian(octave=0)
        mode(4, octave)
      end

      # Return the aeolian mode for the given octave
      def aeolian(octave=0)
        mode(5, octave)
      end

      # Return the locrian mode for the given octave
      def locrian(octave=0)
        mode(6, octave)
      end
    end
  end
end
