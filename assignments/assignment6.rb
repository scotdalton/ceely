$: <<  File.dirname(__FILE__)+'/../lib'
require 'ceely'
require 'pry'
Ceely::Assignment.new("Assignment 6", 620, 670).run do
  def refresh_results
    @dodecaphonic = Ceely::Dodecaphonic::Note.new(@fundamental_frequency.text.to_f, @index.text.to_i)
    @index_para.replace "Index: ", em(@dodecaphonic.index)
    @cents_para.replace "Cents: ", em(@dodecaphonic.cents)
    @raw_frequency_para.replace "Raw Frequency: ", em(@dodecaphonic.raw_frequency)
    @octave_para.replace "Octave: ", em(@dodecaphonic.octave)
    @octave_adjusted_factor_para.replace "Octave Adjusted Factor: ", em(@dodecaphonic.octave_adjusted_factor)
    @frequency_para.replace "Frequency: ", em(@dodecaphonic.frequency)
  end
  fundamental_frequency, index  = 528, 1
  duration, amplitude = 0.5, 50
  flow width: 800, height: 850 do
    flow margin: 20, width: 350, height: 375 do
      background lightgray, curve: 20
      border darkred, curve: 20, strokewidth: 1
      stack margin: 10 do
        subtitle "Dodecaphonic Scale"
      end
      stack margin: 10 do
        para "Base Frequency: "
        @fundamental_frequency = edit_line(fundamental_frequency)
      end
      stack margin: 10 do
        para "Index: "
        @index = edit_line(index)
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
        button("Play the Dodecaphonic Scale") do
          refresh_results
          scale = Ceely::Dodecaphonic::Scale.new(@fundamental_frequency.text.to_i)
          scale.play(@duration.text.to_f, @amplitude.text.to_i)
        end
      end
    end
    flow margin: 20, width: 660, height: 375 do
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
      refresh_results
    end
  end
end
