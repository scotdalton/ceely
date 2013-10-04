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
      MODE_NAMES = %w{ ionian dorian phrygian lydian mixolydian aeolian locrian }
      NOTE_NAMES = %w{ C D E F G A B }
      
      def initialize(fundamental_frequency=528.0, size=12, offset=-1, note_names=NOTE_NAMES)
        super(fundamental_frequency, size, offset, note_names)
      end

      MODE_NAMES.each_with_index do |mode, index|
        define_method(mode) do |octave_index| 
          nth_mode(index + (octave_index*mode_size))
        end

        define_method("alt_#{mode}") do |octave_index|
          alt_nth_mode(index + (octave_index*mode_size))
        end
      end

      # Play the named mode in the given octave
      def play_mode(mode, octave_index, seconds, amplitude, &block)
        raise ArgumentError.new("Don't know that mode") unless MODE_NAMES.include?(mode)
        notes = send(mode.to_sym, octave_index)
        play_notes(notes, seconds, amplitude, &block)
      end

      # Play the named mode in the given octave, using the alternative method
      def play_alt_mode(mode, octave_index, seconds, amplitude, &block)
        raise ArgumentError.new("Don't know that mode") unless MODE_NAMES.include?(mode)
        notes = send("alt_#{mode}".to_sym, octave_index)
        play_notes(notes, seconds, amplitude, &block)
      end
   end
  end
end
