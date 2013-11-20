module Ceely
  module Scales
    module Pythagorean
      # A Pythagorean::Note is a Note with the factor equal to 3/2
      class Note < Ceely::Note
        include Ceely::Mixins::SyntonicComma

        # A pythagorean note has a factor equal to 3/2
        # raised to the power of the index
        def factor
          @factor ||= Rational(3, 2)**index
        end
      end

      # A Pythagorean::Scale is a Scale with a set Pythagorean::Notes
      class Scale < Ceely::Scale
        NOTE_NAMES = %w{ C C# D D# E F Gb F# G G# A A# B }
        NOTE_TYPES = %w{ 1 m2 2 m3 M3 4 b5(b) b5(#) 5 m6 M6 m7 M7 }
        MODE_NAMES = %w{ ionian dorian phrygian lydian mixolydian aeolian locrian }

        def initialize(fundamental_frequency=528.0, *args)
          size = (args.shift || 13)
          offset = (args.shift || -1)
          note_names = (args.shift || NOTE_NAMES)
          note_types = (args.shift || NOTE_TYPES)
          super(fundamental_frequency, size, offset, note_names, note_types)
        end

        MODE_NAMES.each_with_index do |mode, index|
          define_method(mode) do |octave|
            mode_index = index + (octave*(size+1))
            nth_mode(mode_index)
          end
        end

        # Play the named mode in the given octave
        def play_mode(mode, octave, amplitude, &block)
          raise ArgumentError.new("Don't know that mode") unless MODE_NAMES.include?(mode)
          notes = send(mode.to_sym, octave)
          play_notes(notes, amplitude, &block)
        end

        # Override the circle of fifths to reject 
        # one of the diminished fifths, default to Gb
        def circle_of_fifths(diminished_fifth_reject="Gb")
          return @circle_of_fifth if defined? @circle_of_fifths
          @circle_of_fifths = []
          # Reject one of the diminished fifths
          sorted_notes.reject! { |note| note.name.eql? diminished_fifth_reject }
          # Start at the beginning
          @circle_of_fifths << sorted_notes.first
          (1..(sorted_notes.size-1)).step do
            @circle_of_fifths << sorted_notes.rotate!(7).first
          end
          @circle_of_fifths
        end
      end
    end
  end
end
