module Ceely
  module Scales
    module Harmonic
      # A Harmonic::Note is a Note
      class Note < Ceely::Note;end

      # A Harmonic::Scale is a Scale with the set of Harmonic::Notes
      class Scale < Ceely::Scale
        def initialize(fundamental_frequency=528.0, size=33, offset=0)
          # A harmonic note has a factor that is a multiple of the fundamental
          # which means it's the same as the index of the relationship
          factor = -> note { Rational(note.index + 1) }
          super(fundamental_frequency, factor, size, offset)
        end

        def sort(size=nil)
          super(size).collect do |note|
            case note.index
            when 0
              note.name = "C"
              note.type = "1"
            when 2
              note.name = "G"
              note.type = "5"
            when 6
              note.name = "Bb"
              note.type = "m7"
            when 17
              note.name = "D"
              note.type = "M2"
            when 18
              note.name = "Eb"
              note.type = "m3"
            when 19
              note.name = "E"
              note.type = "M3"
            when 20
              note.name = "F"
              note.type = "4"
            when 24
              note.name = "Ab"
              note.type = "m6"
            when 26
              note.name = "A"
              note.type = "M6"
            when 29
              note.name = "B"
              note.type = "M7"
            end
            note
          end
        end
      end
    end
  end
end
