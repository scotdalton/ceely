module Ceely
  # A Chord is a NoteSet
  class Chord < Ceely::NoteSet

    # Play the chord
    def play(amplitude, &block)
      play_chord(duration, amplitude, &block)
    end

    def play_chord(seconds, amplitude, &block)
      # Set the duration of each tone
      tones.each { |tone| tone.duration = seconds }
      # Play them
      player.play_tones(tones, amplitude)
    end

    def tones
      @tones ||= notes.collect { |note| note.tone }
    end
  end
end
