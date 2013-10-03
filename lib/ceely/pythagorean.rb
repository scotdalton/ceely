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

      def play_mode(mode, octave_index, seconds, amplitude, &block)
        notes = send(mode.to_sym, octave_index)
        play_notes(notes, seconds, amplitude, &block)
      end

      # Return the ionian mode for the given octave
      def ionian(octave_index=0)
        nth_mode(0 + (octave_index*mode_size))
      end

      # Return the dorian mode for the given octave
      def dorian(octave_index)
        nth_mode(1 + (octave_index*mode_size))
      end

      # Return the phrygian mode for the given octave
      def phrygian(octave_index=0)
        nth_mode(2 + (octave_index*mode_size))
      end

      # Return the lydian mode for the given octave
      def lydian(octave_index=0)
        nth_mode(3 + (octave_index*mode_size))
      end

      # Return the mixolydian mode for the given octave
      def mixolydian(octave_index=0)
        nth_mode(4 + (octave_index*mode_size))
      end

      # Return the aeolian mode for the given octave
      def aeolian(octave_index=0)
        nth_mode(5 + (octave_index*mode_size))
      end

      # Return the locrian mode for the given octave
      def locrian(octave_index=0)
        nth_mode(6 + (octave_index*mode_size))
      end
   end
  end
end
