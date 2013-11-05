module Ceely
  module SongBook
    class RowRowRowYourBoat < Ceely::Song
      def initialize(*args)
        super(*args)
        notes_by_name!(*%w{ C C C D E })
        pause!(0.125)
        notes_by_name!(*%w{ E D E F G })
        # Get a copy of C from the key
        fast_c = key.note_by_name("C").in_octave(0)
        # Speed it up
        fast_c.duration = tempo/3.0
        pause!(0.125)
        # Add the C mer-ri-ly s
        self << fast_c << fast_c << fast_c
        # Get a copy of G from the key
        fast_g = key.note_by_name("G").in_octave(0)
        # Speed it up
        fast_g.duration = tempo/3.0
        # Add the G mer-ri-ly s
        pause!(0.125)
        self << fast_g << fast_g << fast_g
        # Get a copy of E from the key
        fast_e = key.note_by_name("E").in_octave(0)
        # Speed it up
        fast_e.duration = tempo/3.0
        # Add the G mer-ri-ly s
        self << fast_e << fast_e << fast_e
        pause!(0.125)
        notes_by_name!(*%w{ G F E D C })
      end
    end
  end
end
