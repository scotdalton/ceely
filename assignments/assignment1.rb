$: <<  File.dirname(__FILE__)+'/../lib'
require 'ceely'
Ceely::Assignment.new("Assignment 1", 500, 200).run do
  # According to
  # http://www.thewhippinpost.co.uk/tools/note-to-freq.htm
  # 400hz = G3 = 67
  pitch, duration = 67, 5
  note = Ceely::Note.new(pitch, Ceely::Instrument.new(8, 81, 'soundbank-deluxe'))
  stack margin: 30 do
    stack margin: 10 do
      para "Pitch: ", em(pitch)
    end
    # stack margin: 10 do
    #   para "Frequency: ", em(note.frequency)
    # end
    stack margin: 10 do
      para "Duration: ", em(duration)
    end
    stack margin: 10 do
      button("Play the tone with pitch #{pitch} for #{duration} seconds") do
        note.play do
          sleep duration
        end
      end
    end
    stack margin: 10 do
      button("Play the tone with pitch #{pitch} for #{duration} seconds via SympleSynth") do
        note.play_simple_synth do
          sleep duration
        end
      end
    end
  end
end
