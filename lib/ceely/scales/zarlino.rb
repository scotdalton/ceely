module Ceely
  module Scales
    module Zarlino
      # A Zarlino::Note is a Note with whose factor
      # depends on its parent based on a 4:5:6
      # relationship
      class Note < Ceely::Note
        FOURS = [0, 3, 4]
        
        attr_reader :parent, :grandparent, :child, :grandchild, :doppelganger

        def initialize(relations, *args)
          @parent = relations[:parent]
          @child = relations[:child]
          @grandchild = child.child if child
          @grandparent = parent.parent if parent
          @doppelganger = relations[:doppelganger]
          super(*args)
        end

        # Zarlino Notes hav factors based on 4:5:6
        # but in a crazy recursive way based on its relations
        # except if it's the tonic
        def factor
          return @factor if defined? @factor
          # Factor is the octave if it's the tonic or in the octave
          return @factor = Rational(index/7 + 1) if (index%7).eql?(0)
          # If the grandparent is in the four group, the ratio is 6/5
          ratio ||= Rational(6, 5) if grandparent and FOURS.include?(grandparent.index)
          # If the parent is in the four group, the ratio is 5/4
          ratio = Rational(5, 4) if parent and FOURS.include?(parent.index)
          # If we have a grandchild, the ratio is 4/5
          ratio ||= Rational(4, 5) if grandchild
          # If we have a child only, the ratio is 5/6
          ratio ||= Rational(5, 6) if child
          unless ratio.nil?
            # Multiply that by the relation's factor, cuz that's in terms of the tonic
            relation = (parent || child)
            return @factor = (ratio * relation.factor)
          end
          # If all else fails, get our doppelganger's octave adjusted factor
          return @factor = doppelganger.octave_adjusted_factor
        end

        def in_octave(octave)
          self.class.new({}, frequency*(2**octave), 0, name, type)
        end

        def flatten(interval)
          self.class.new({}, frequency*(1/interval), 0, "#{name} b")
        end

        def sharpen(interval)
          self.class.new({}, frequency*interval, 0, "#{name} #")
        end
      end

      # A Zarlino::Scale is a Scale with a set Pythagorean::Notes
      class Scale < Ceely::Scale
        NOTE_NAMES = %w{ C D E F G A B }
        NOTE_TYPES = %w{ 1 M2 M3 4 5 M6 M7 }

        # Make notes from the module name
        def new_note(index, relations={})
          name = self.class.name.deconstantize + "::Note"
          name.constantize.new(relations, fundamental_frequency, index)
        end

        def note_by_index(index, relations={})
          note = @notes.find { |note| note.index.eql? index }
          (note.blank?) ? new_note(index, relations) : note 
        end

        def initialize(fundamental_frequency=528.0, *args)
          @fundamental_frequency = fundamental_frequency
          parent = nil
          @notes = 0.step(8, 2).collect do |index|
            note = new_note(index, {parent: parent})
            parent = note
            note
          end
          # Pop the last one and get the runt
          @notes << new_note(1, {doppelganger: @notes.pop})
          # Determine the rest from the octave
          child = new_note(7)
          @notes += 5.step(3, -2).collect do |index|
            note = new_note(index, {child: child})
            child = note
            note
          end
          super(fundamental_frequency, 7, 0, NOTE_NAMES, NOTE_TYPES)
          @naturals = NOTE_TYPES.collect { |type| note_by_type(type) }
        end
      end
    end
  end
end
