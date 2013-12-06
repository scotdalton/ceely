module Ceely
  module Scales
    module EvenTempered
      # An EvenTempered::Note is a Note with the factor equal to 3/2
      class Note < Ceely::Note

        def initialize(fundamental_frequency, factor, index=0, octave=nil, *args)
          octave ||= index/12
          super(fundamental_frequency, factor, index, octave, *args)
        end
      end

      # An EvenTempered::Scale is a Scale with a set EvenTempered::Notes
      class Scale < Ceely::Scale
        NOTE_NAMES = %w{ C C# D D# E F F# G G# A A# B }
        NOTE_TYPES = %w{ 1 m2 2 m3 M3 4 b5 5 m6 M6 m7 M7 }

        def initialize(fundamental_frequency=528.0, *args)
          size = args.shift
          offset = args.shift
          note_names = (args.shift || NOTE_NAMES)
          note_types = (args.shift || NOTE_TYPES)
          # A even tempered note has a factor equal to 12 root 2
          # raised to the power of the index
          factor = -> note { (2 ** (1.0/12))**note.index }
          super(fundamental_frequency, factor, size, offset, note_names, note_types)
        end
      end
    end
  end
end
