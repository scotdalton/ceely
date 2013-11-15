module Ceely
  # A Harmony is a NoteSet
  class Harmony < Ceely::NoteSet

    # Play the harmony
    def play(*amplitudes)
      # Set the duration of each tone
      tones.each { |tone| tone.duration = duration }
      # Play them
      player.play_tones(tones, *amplitudes)
    end
  end
end
