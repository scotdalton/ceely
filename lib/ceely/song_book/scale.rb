module Ceely
  module SongBook
    class Scale < Ceely::Song
      def initialize(*args)
        super(*args)
        key.sorted_notes.each do |note|
          note_by_name!(note.name)
          pause!(0.5)
        end
        self << key.note_by_name("C").in_octave(1)
      end
    end
  end
end
