module Ceely
  module SongBook
    class MaryHadALittleLamb < Ceely::Song
      def initialize(*args)
        super(*args)
        notes_by_name!(*%w{ B A G A B B B })
        pause!(0.125)
        notes_by_name!(*%w{ A A A })
        pause!(0.125)
        b = scale.note_by_name("B")
        self << b
        # Add the Ds in the next octave
        d = scale.note_by_name("D")
        self << d.in_octave(1) << d.in_octave(1)
        pause!(0.25)
        notes_by_name!(*%w{ B A G A B B B })
        notes_by_name!(*%w{ B A A B A G})
        # End with a power chord!
        # chord_by_names!("C", "G")
      end
    end
  end
end
