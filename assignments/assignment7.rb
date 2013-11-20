$: <<  File.dirname(__FILE__)+'/../lib'
require 'ceely'
INDEXES = %w{ -5 -4 -3 -2 -1 0 1 2 3 4 5 6 }
Ceely::Gui::Assignment.new("Assignment 7", 700, 750).run do
  def refresh_results
    @index.choose("1") if @index.text.blank?
    @scale = Ceely::Scales::Ptolemaic::Scale.new(@fundamental_frequency.text.to_f)
    @note = @scale.sort.find { |note| note.index.eql? @index.text.to_i }
    @index_para.replace "Index: ", em(@note.index)
    @cents_para.replace "Cents: ", em(@note.cents)
    @raw_frequency_para.replace "Raw Frequency: ", em(@note.raw_frequency)
    @octave_para.replace "Octave: ", em(@note.raw_octave)
    @octave_adjusted_factor_para.replace "Octave Adjusted Factor: ", em(@note.octave_adjusted_factor)
    @frequency_para.replace "Frequency: ", em(@note.frequency)
    @name_para.replace "Name: ", em(@note.name)
    @type_para.replace "Type: ", em(@note.type)
  end
  fundamental_frequency, index  = 528, 1
  duration, amplitude = 0.5, 50
  flow width: 700, height: 750 do
    flow margin: 20, width: 350, height: 375 do
      background lightgray, curve: 20
      border darkred, curve: 20, strokewidth: 1
      stack margin: 10 do
        subtitle "Ptolemaic Scale"
      end
      stack margin: 10 do
        para "Base Frequency: "
        @fundamental_frequency = edit_line(fundamental_frequency)
      end
      stack margin: 10 do
        para "Index: "
        @index = list_box items: INDEXES, choose: "1" do |list|
          refresh_results
        end
      end
      stack margin: 10 do
        button("Refresh the Stats") do
          refresh_results
        end
      end
    end
    flow margin: 20, width: 350, height: 375 do
      background lightgray, curve: 20
      border darkred, curve: 20, strokewidth: 1
      flow margin: 10 do
        subtitle("Play the Scale")
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
        button("Play the Ptolemaic Scale") do
          refresh_results
          duration = @duration.text.to_f
          amplitude = @amplitude.text.to_i
          scale = @scale
          Thread.new do
            scale.duration = duration
            scale.play(amplitude)
          end
        end
      end
    end
    flow margin: 20, width: 700, height: 375 do
      background lightgray, curve: 20
      border darkred, curve: 20, strokewidth: 1
      flow margin: 10 do
        subtitle("The Stats")
      end
      flow margin: 10 do
        @index_para = para ""
      end
      flow margin: 10 do
        @cents_para = para ""
      end
      flow margin: 10 do
        @raw_frequency_para = para ""
      end
      flow margin: 10 do
        @octave_para = para ""
      end
      flow margin: 10 do
        @octave_adjusted_factor_para = para ""
      end
      flow margin: 10 do
        @frequency_para = para ""
      end
      flow margin: 10 do
        @name_para = para ""
      end
      flow margin: 10 do
        @type_para = para ""
      end
      refresh_results
    end
  end
end
