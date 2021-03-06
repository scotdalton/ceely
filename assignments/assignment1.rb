$: <<  File.dirname(__FILE__)+'/../lib'
require 'ceely'
Ceely::Gui::Assignment.new("Assignment 1", 500, 400).run do
  frequency, duration, amplitude = 440, 5, 50
  background lightgray, curve: 20
  border darkred, curve: 20, strokewidth: 1
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
      button("Crash, Bang, Boom") do
        tone = Ceely::Tone.new(@frequency.text.to_i, @duration.text.to_i)
        tone.play(@amplitude.text.to_i)
      end
    end
  end
end
