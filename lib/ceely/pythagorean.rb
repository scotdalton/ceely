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
      
      def initialize(fundamental_frequency=528.0, size=12, offset=-1, note_names=NOTE_NAMES)
        super(fundamental_frequency, size, offset, note_names)
      end

      # Return the ionian mode for the given octave
      def ionian(octave=0)
        ith_mode(0 + (octave*size))
      end

      def play_ionian(octave=0)
        play_ith_mode(0 + (octave*size))
      end

      # Return the dorian mode for the given octave
      def dorian(octave=0)
        ith_mode(1 + (octave*size))
      end

      # Return the phrygian mode for the given octave
      def phrygian(octave=0)
        ith_mode(2 + (octave*size))
      end

      # Return the lydian mode for the given octave
      def lydian(octave=0)
        ith_mode(3 + (octave*size))
      end

      # Return the mixolydian mode for the given octave
      def mixolydian(octave=0)
        ith_mode(4 + (octave*size))
      end

      # Return the aeolian mode for the given octave
      def aeolian(octave=0)
        ith_mode(5 + (octave*size))
      end

      # Return the locrian mode for the given octave
      def locrian(octave=0)
        ith_mode(6 + (octave*size))
      end
    end
  end
end
