$: <<  File.dirname(__FILE__)+'/../lib'
require 'ceely'
require 'pry'
MODES = %w{ Ionian Dorian Phrygian Lydian Mixolydian Aeolian Locrian }
Ceely::Assignment.new("Assignment 4", 620, 620).run do
  @pythagorean = Ceely::Pythagorean::Scale.new
  def refresh_results
    @modes.choose("Ionian") if @modes.text.blank?
    selected_mode = @modes.text
    @mode = 
      @pythagorean.send(selected_mode.downcase.to_sym, @octave.text.to_i)
    notes =  @mode.notes.collect { |note| note.name }.join(", ")
    frequencies = 
      @mode.notes.collect { |note| note.octave_adjusted_frequency }.join(", ")
    @mode_para.replace "Mode: ", em(selected_mode)
    @notes_para.replace "Notes: ", em(notes)
    @frequencies_para.replace "Frequencies: ", em(frequencies)
  end
  octave, duration, amplitude = 0, 0.5, 50
  flow width: 800, height: 800 do
    flow margin: 20, width: 660, height: 350 do
      background lightgray, curve: 20
      border darkred, curve: 20, strokewidth: 1
      flow margin: 10 do
        subtitle "Play Pythagorean Modes"
      end
      flow margin: 10 do
        para "Choose the Mode: "
        @modes = list_box items: MODES, choose: "Ionian" do |list|
          refresh_results
        end
      end
      flow margin: 10 do
        para "and the Octave: "
        @octave = edit_line(octave)
      end
      flow margin: 10 do
        para "and the Durations (in seconds): "
        @duration = edit_line(duration)
      end
      stack margin: 10 do
        para "and the Amplitude: "
        @amplitude = edit_line(amplitude)
      end
      flow margin: 10 do
        button("Refresh the Stats") do
          refresh_results
        end
        button("Play the Selected Mode") do
          refresh_results
          scale = @mode
          scale.play(@duration.text.to_f, @amplitude.text.to_i)
        end
      end
    end
    flow margin: 20, width: 660, height: 350 do
      background lightgray, curve: 20
      border darkred, curve: 20, strokewidth: 1
      flow margin: 10 do
        subtitle("The Stats")
      end
      flow margin: 10 do
        @mode_para = para ""
      end
      flow margin: 10 do
        @octave_para = para ""
      end
      flow margin: 10 do
        @notes_para = para ""
      end
      flow margin: 10 do
        @intervals_para = para ""
      end
      flow margin: 10 do
        @frequencies_para = para ""
      end
    end
  end
  refresh_results
end
