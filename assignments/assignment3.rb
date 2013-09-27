$: <<  File.dirname(__FILE__)+'/../lib'
require 'ceely'
require 'pry'
Ceely::Assignment.new("Assignment 3", 620, 620).run do
  def refresh_results
    @pythagorean = Ceely::Pythagorean::Note.new(@fundamental_frequency.text.to_f, @index.text.to_i)
    @index_para.replace "Index: ", em(@pythagorean.index)
    @frequency_para.replace "Frequency: ", em(@pythagorean.frequency)
    @octave_para.replace "Octave: ", em(@pythagorean.octave)
    @octave_adjusted_factor_para.replace "Octave Adjusted Factor: ", em(@pythagorean.octave_adjusted_factor)
    @octave_adjusted_frequency_para.replace "Octave Adjusted Frequency: ", em(@pythagorean.octave_adjusted_frequency)
  end
  fundamental_frequency, index  = 528, 1
  scale_size, scale_offset, duration, amplitude = 12, -1, 1, 50
  flow width: 800, height: 800 do
    flow margin: 20, width: 350, height: 350 do
      background lightgray, curve: 20
      border darkred, curve: 20, strokewidth: 1
      stack margin: 10 do
        subtitle "The Pythagorean"
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
        button("Show the Stats") do
          refresh_results
        end
      end
    end
    flow margin: 20, width: 350, height: 350 do
      background lightgray, curve: 20
      border darkred, curve: 20, strokewidth: 1
      flow margin: 10 do
        subtitle("The Stats")
      end
      flow margin: 10 do
        @index_para = para ""
      end
      flow margin: 10 do
        @frequency_para = para ""
      end
      flow margin: 10 do
        @octave_para = para ""
      end
      flow margin: 10 do
        @octave_adjusted_factor_para = para ""
      end
      flow margin: 10 do
        @octave_adjusted_frequency_para = para ""
      end
      refresh_results
    end
    flow margin: 20, width: 350, height: 350 do
      background lightgray, curve: 20
      border darkred, curve: 20, strokewidth: 1
      flow margin: 10 do
        subtitle("Play the Scale")
      end
      stack margin: 10 do
        para "Number of Notes in the Scale: "
        @scale_size = edit_line(scale_size)
      end
      stack margin: 10 do
        para "Offset of the Scale: "
        @scale_offset = edit_line(scale_offset)
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
        button("Play the Pythagorean Scale") do
          refresh_results
          scale = Ceely::Pythagorean::Scale.new(
            @fundamental_frequency.text.to_i, @scale_size.text.to_i, 
              @scale_offset.text.to_i)
          scale.play(@duration.text.to_f, @amplitude.text.to_i)
        end
      end
    end
    flow margin: 20, width: 350, height: 350 do
      background lightgray, curve: 20
      border darkred, curve: 20, strokewidth: 1
    end
  end
end