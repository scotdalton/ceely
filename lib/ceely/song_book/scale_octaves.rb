module Ceely
  module SongBook
    class ScaleOctaves < Ceely::Song
      def initialize(*args)
        octaves = args.pop
        super(*args)
        octaves.times do |octave|
          scale.sorted_notes.each do |note|
            self << note.in_octave(octave)
            pause!(0.5)
          end
        end
      end
    end
  end
end
