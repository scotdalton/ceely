module Ceely
  # Class to (pseudo)randomly generate songs of a certain size
  class RandomSongGenerator
    attr_reader :song, :size
    
    def initialize(scale, tempo, size)
      @size = size
      @song = Song.new(scale, tempo)
      prng = Random.new(Time.now.to_i)
      size.times do
        random_note_name_index = prng.rand(scale.size)
        random_note_name = scale.note_name(random_note_name_index)
        random_note = scale.note_by_name(random_note_name)
        random_octave = prng.rand(2)
        song << random_note.in_octave(random_octave)
      end
    end
  end
end
