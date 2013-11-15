module Ceely
  # A Chord is a NoteSet
  class Chord < Ceely::NoteSet

    # Play the chord
    def play(amplitude)
      # Set the duration of each tone
      tones.each { |tone| tone.duration = duration }
      # Play them
      player.play_tones(tones, amplitude)
    end
  end
end
