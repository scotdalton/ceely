module Ceely
  module Scales
    module Rameau
      # A Rameau::Note is a Note
      class Note < Ceely::Note
        include Ceely::Mixins::SyntonicComma

        attr_accessor :tonic, :fourth, :fifth, :parent

        def tonic?
          @tonic.present?
        end

        def fourth?
          @fourth.present?
        end

        def fifth?
          @fifth.present?
        end

        def grandparent
          parent.parent if parent
        end

        def pure_third
          harmonic_third.octave_adjusted_factor
        end

        def dominant
          Rational(3,2)
        end

        def subdominant
          Rational(4,3)
        end

        def just_wholetone
          dominant/subdominant
        end

        def just_semitone
          subdominant/pure_third
        end
      end

      # A Rameau::Scale is a Scale built with 
      # fifths and fourths
      class Scale < Ceely::Scale
        NOTE_NAMES = %w{ C D E F G A B }
        NOTE_TYPES = %w{ 1 M2 M3 4 5 M6 M7 }

        def initialize(fundamental_frequency=528.0, *args)
          @fundamental_frequency = fundamental_frequency
          note_names = (args.shift || NOTE_NAMES)
          note_types = (args.shift || NOTE_TYPES)
          @factor = -> note do
            # If the note is the tonic, the factor is 1
            return Rational(1) if note.tonic?
            # If the note is the a fourth, the factor is the subdominant
            return note.subdominant if note.fourth?
            # If the note is the a fifth, the factor is the dominant
            return note.dominant if note.fifth?
            # If the note is has a grandparent (i.e. the third note in a chord)
            # the factor is (the dominant x the parent's factor)
            return note.dominant*note.grandparent.octave_adjusted_factor if note.grandparent.present?
            # If the note is has a parent (i.e. the second note in a chord)
            # the factor is (the pure third x the parent's factor)
            return note.pure_third*note.parent.octave_adjusted_factor if note.parent.present?
            # Raise an error cuz you're doing it wrong
            raise RuntimeError.new("You're doing it wrong!")
          end
          # Create the tonic
          tonic = new_note(0)
          tonic.tonic = true
          # Create the fourth
          fourth = new_note(3)
          fourth.fourth = true
          # Create the fifth
          fifth = new_note(6)
          fifth.fifth = true
          # Start with the tonic, fourth and fifth
          starting_notes = [tonic, fourth, fifth]
          # Get the chords based on the starting notes
          chords = starting_notes.collect do |note|
            note1 = new_note(note.index + 1)
            note1.parent = note
            note2 = new_note(note1.index + 1)
            note2.parent = note1
            [note, note1, note2]
          end
          @notes = chords.flatten
          # Toss in the octave
          # @notes << tonic.in_octave(1)
          @notes.uniq! { |note| note.frequency }
          super(fundamental_frequency, @factor, 7, 0, note_names, note_types)
          @naturals = NOTE_TYPES.collect { |type| note_by_type(type) }
        end

        def sharpen()
          # Get the fifth
          fifth = note_by_type("5")
          new_scale = in_key(fifth)
          # Adjust name of the sharp note
          sharp_note = new_scale.note_by_type("M7")
          sharp_note.name = "#{sharp_note.name}#"
          # Return the new scale
          new_scale
        end

        def flatten()
          # Get the fourth
          fourth = note_by_type("4")
          new_scale = in_key(fourth)
          # Adjust name of the flat note
          flat_note = new_scale.note_by_type("4")
          flat_note.name = "#{flat_note.name}b"
          # Return the new scale
          new_scale
        end

        def in_key(starting_note)
          # Get the starting notes position in the sorted notes
          new_index = sorted_notes.index(starting_note)
          # Get a copy of the note names and types, rotated
          note_names = self.note_names.rotate(new_index)
          # Get a new scale based on the new frequency and names
          self.class.new(starting_note.frequency, note_names)
        end
      end
    end
  end
end
