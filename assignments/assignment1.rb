# Assumes SimpleSynth is installed and running with the desired MIDI instrument
# https://github.com/notahat/simplesynth
$: <<  File.dirname(__FILE__)+'/../lib'
require 'ceely'
Ceely::Assignment.new("Assignment 1", 500, 200).run do
  # According to
  # http://www.thewhippinpost.co.uk/tools/note-to-freq.htm
  # 400hz = G3 = 67
  frequency, duration = 440, 5
  note = Ceely::Note.new(frequency)
  stack margin: 30 do
    stack margin: 10 do
      para "Frequency: ", em(note.frequency)
    end
    stack margin: 10 do
      para "Pitch: ", em(note.pitch)
    end
    stack margin: 10 do
      para "Duration: ", em(duration)
    end
    stack margin: 10 do
      button("Play the tone with frequency #{frequency} for #{duration} seconds") do
        note.play(duration)
      end
    end
    stack margin: 10 do
      button("Play the tone with frequency #{frequency} for #{duration} seconds via SympleSynth") do
        note.play_midi(duration)
      end
    end
  end
end
