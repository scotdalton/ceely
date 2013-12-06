module Ceely
  module Scales
    module Zarlino
      # A Zarlino::Note is a Note
      class Note < Ceely::Note
        attr_accessor :parent, :child, :doppelganger

        def grandparent
          parent.parent if parent
        end

        def grandchild
          child.child if child
        end
      end

      # A Zarlino::Scale is a Scale with a set of Zarlino::Notes
      # Zarlino Notes have factors based on 4:5:6
      # but in a crazy recursive way based on its relations
      # except if it's the tonic
      class Scale < Ceely::Scale
        NOTE_NAMES = %w{ C D E F G A B }
        NOTE_TYPES = %w{ 1 M2 M3 4 5 M6 M7 }
        FOURS = [0, 3, 4]

        def initialize(fundamental_frequency=528.0, *args)
          @fundamental_frequency = fundamental_frequency
          @factor = -> note {
            # Zarlino Notes have factors based on 4:5:6
            # but in a crazy recursive way based on its relations
            # except if it's the tonic
            # Factor is the octave if it's the tonic or in the octave
            return Rational(note.index/7 + 1) if (note.index%7).eql?(0)
            # If the grandparent is in the four group, the ratio is 6/5
            ratio = Rational(6, 5) if note.grandparent and FOURS.include?(note.grandparent.index)
            # If the parent is in the four group, the ratio is 5/4
            ratio ||= Rational(5, 4) if note.parent and FOURS.include?(note.parent.index)
            # If we have a grandchild, the ratio is 4/5
            ratio ||= Rational(4, 5) if note.grandchild
            # If we have a child only, the ratio is 5/6
            ratio ||= Rational(5, 6) if note.child
            unless ratio.nil?
              # Multiply that by the relation's factor, cuz that's in terms of the tonic
              relation = (note.parent || note.child)
              return (ratio * relation.factor)
            end
            # If all else fails, get our doppelganger's octave adjusted factor
            return note.doppelganger.octave_adjusted_factor
          }
          parent = nil
          # Starting at 0, step up to 8 by 2s
          # and base the factors on the ancestors
          @notes = 0.step(8, 2).collect do |index|
            # Create the note
            note = new_note(index)
            # Set the parent
            note.parent = parent
            # Prepare the next generation
            parent = note
            # Return the note
            note
          end
          # Pop the last one and get the runt
          doppelganger = @notes.pop
          # Create a new note with index 1
          note = new_note(1)
          # Set the doppelganger
          note.doppelganger = doppelganger
          @notes << note
          # Get the child as the octave
          child = new_note(7)
          # Starting at 5, step down to 3 by 2s
          # and determine the factor from the octave
          @notes += 5.step(3, -2).collect do |index|
            # Create the note
            note = new_note(index)
            # Set the child
            note.child = child
            # Prepare the previous generation
            child = note
            # Return the note
            note
          end
          super(fundamental_frequency, @factor, 7, 0, NOTE_NAMES, NOTE_TYPES)
          @naturals = NOTE_TYPES.collect { |type| note_by_type(type) }
        end
      end
    end
  end
end
