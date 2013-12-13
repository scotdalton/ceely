module Ceely
  module SongBook
    class Scale < Ceely::Song
      def initialize(*args)
        super(*args)
        scale.sorted_notes.each do |note|
          note_by_name!(note.name)
          pause!(0.5)
        end
        self << scale.note_by_type("1").in_octave(1)
      end
    end
  end
end
