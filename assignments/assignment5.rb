$: <<  File.dirname(__FILE__)+'/../lib'
require 'ceely'
Ceely::Assignment.new("Assignment 5", 620, 670).run do
  def refresh_results
    @scale = Ceely::EvenTempered::Scale.new(@fundamental_frequency.text.to_f)
    @note = @scale.sort.find { |note| note.index.eql? @index.text.to_i }
    @index_para.replace "Index: ", em(@note.index)
    @cents_para.replace "Cents: ", em(@note.cents)
    @raw_frequency_para.replace "Raw Frequency: ", em(@note.raw_frequency)
    @octave_para.replace "Octave: ", em(@note.octave)
    @octave_adjusted_factor_para.replace "Octave Adjusted Factor: ", em(@note.octave_adjusted_factor)
    @frequency_para.replace "Frequency: ", em(@note.frequency)
    @name_para.replace "Name: ", em(@note.name)
    @type_para.replace "Type: ", em(@note.type)
  end
  fundamental_frequency, index  = 528, 1
  scale_size, scale_offset, duration, amplitude = 12, 0, 0.5, 50
  flow width: 800, height: 850 do
    flow margin: 20, width: 350, height: 375 do
      background lightgray, curve: 20
      border darkred, curve: 20, strokewidth: 1
      stack margin: 10 do
        subtitle "Even Tempered Scale"
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
        button("Play the Even Tempered Scale") do
          refresh_results
          Thread.new do
            @scale.play(@duration.text.to_f, @amplitude.text.to_i)
          end
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
