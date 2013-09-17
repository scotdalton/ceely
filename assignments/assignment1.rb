# Assumes SimpleSynth is installed and running with the desired MIDI instrument
# https://github.com/notahat/simplesynth
$: <<  File.dirname(__FILE__)+'/../lib'
require 'ceely'
require 'jsound'
Ceely::Assignment.new("Assignment 1", 500, 200).run do
  # According to
  # http://www.thewhippinpost.co.uk/tools/note-to-freq.htm
  # 400hz = G3 = 67
  frequency, duration = 440, 5
  output = JSound::Midi::OUTPUTS.find /SimpleSynth/ if output.nil?
  stack margin: 30 do
    stack margin: 10 do
      para "Frequency: "
      @frequency = edit_line frequency
    end
    stack margin: 10 do
      para "Pitch: ", em { @note.pitch }
    end
    stack margin: 10 do
      para "Duration: ", em(duration)
    end
    stack margin: 10 do
      button("Play the tone with frequency #{frequency} for #{duration} seconds") do
        @note = Ceely::Note.new(@frequency.text.to_i)
        @note.play(duration)
      end
    end
    stack margin: 10 do
      button("Play the tone with frequency #{frequency} for #{duration} seconds via SympleSynth") do
        @note = Ceely::Note.new(@frequency.text.to_i)
        @note.play_midi(duration, output)
      end
    end
  end
end
