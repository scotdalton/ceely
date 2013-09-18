$: <<  File.dirname(__FILE__)+'/../lib'
require 'ceely'
Ceely::Assignment.new("Assignment 1", 500, 400).run do
  frequency, duration, amplitude = 440, 5, 50
  stack margin: 30 do
    stack margin: 10 do
      title "Make some noise!"
    end
    stack margin: 10 do
      para "Frequency: "
      @frequency = edit_line(frequency)
    end
    stack margin: 10 do
      para "Duration: "
      @duration = edit_line(duration)
    end
    stack margin: 10 do
      para "Amplitude: "
      @amplitude = edit_line(amplitude)
    end
    stack margin: 10 do
      button("Play the tone.") do
        note = Ceely::Note.new(@frequency.text.to_i)
        note.play(@duration.text.to_i, @amplitude.text.to_i)
      end
    end
    # require 'jsound'
    # output = JSound::Midi::OUTPUTS.find /SimpleSynth/ if output.nil?
    # stack margin: 10 do
    #   @play_midi = button("Play the tone with frequency #{frequency} for #{duration} seconds via SympleSynth") do
    #     @note = Ceely::Note.new(@frequency.text.to_i)
    #     @note.play_midi(duration, output)
    #   end
    # end
  end
end
