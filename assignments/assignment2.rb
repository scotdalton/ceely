$: <<  File.dirname(__FILE__)+'/../lib'
require 'ceely'
require 'pry'
Ceely::Assignment.new("Assignment 2", 620, 620).run do
  def refresh_results
    @fundamental = Ceely::Note::Base.new(@fundamental_frequency.text.to_i)
    @harmonic = Ceely::Note::Harmonic.new(@fundamental, @degree.text.to_i)
    @degree_para.replace "Degree: ", em(@harmonic.degree)
    @frequency_para.replace "Frequency: ", em(@harmonic.frequency)
    @octave_para.replace "Octave: ", em(@harmonic.octave)
    @octave_ratio_para.replace "Octave Ratio: ", em(@harmonic.octave_ratio)
    @octave_frequency_para.replace "Octave Frequency: ", em(@harmonic.octave_frequency)
  end
  fundamental_frequency, degree  = 528, 1
  scale_size, duration, amplitude = 12, 1, 50
  flow width: 800, height: 800 do
    flow margin: 20, width: 350, height: 350 do
      background lightgray, curve: 20
      border darkred, curve: 20, strokewidth: 1
      stack margin: 10 do
        subtitle "The Harmonic"
      end
      stack margin: 10 do
        para "Base Frequency: "
        @fundamental_frequency = edit_line(fundamental_frequency)
      end
      stack margin: 10 do
        para "Degree: "
        @degree = edit_line(degree)
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
        @degree_para = para ""
      end
      flow margin: 10 do
        @frequency_para = para ""
      end
      flow margin: 10 do
        @octave_para = para ""
      end
      flow margin: 10 do
        @octave_ratio_para = para ""
      end
      flow margin: 10 do
        @octave_frequency_para = para ""
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
        para "Duration: "
        @duration = edit_line(duration)
      end
      stack margin: 10 do
        para "Amplitude: "
        @amplitude = edit_line(amplitude)
      end
      stack margin: 10 do
        button("Play the Harmonic Scale") do
          refresh_results
          scale = Ceely::Scale::Harmonic.new(@fundamental, @scale_size.text.to_i)
          scale.play(@duration.text.to_i, @amplitude.text.to_i)
        end
      end
    end
    flow margin: 20, width: 350, height: 350 do
      background lightgray, curve: 20
      border darkred, curve: 20, strokewidth: 1
    end
  end
end
