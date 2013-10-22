module Ceely
  module Natural
    # A Natural::Note is just a Pythagorean Note
    class Note < Ceely::Pythagorean::Note
    end

    # The Natural::Scale is the first 7 notes of the
    # Pythagorean::Scale with the modes defined
    class Scale < Ceely::Pythagorean::Scale
      MODE_NAMES = %w{ ionian dorian phrygian lydian mixolydian aeolian locrian }
      NOTE_NAMES = %w{ C D E F G A B }
      
      def initialize(fundamental_frequency=528.0)
        super(fundamental_frequency, 7, -1, NOTE_NAMES)
      end

      MODE_NAMES.each_with_index do |mode, index|
        define_method(mode) do |octave_index|
          mode_index = index + (octave_index*(size+1))
          nth_mode(mode_index)
        end
      end

      # Play the named mode in the given octave
      def play_mode(mode, octave_index, seconds, amplitude, &block)
        raise ArgumentError.new("Don't know that mode") unless MODE_NAMES.include?(mode)
        notes = send(mode.to_sym, octave_index)
        play_notes(notes, seconds, amplitude, &block)
      end
    end
  end
end
