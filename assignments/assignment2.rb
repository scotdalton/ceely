$: <<  File.dirname(__FILE__)+'/../lib'
require 'ceely'
require 'pry'
Ceely::Assignment.new("Assignment 2", 500, 500).run do
  def refresh_results()
    @base_note = Ceely::Note.new(@base_frequency.text.to_i)
    @harmonic_note = Ceely::HarmonicNote.new(@base_note, @degree.text.to_i)
    @degree_para.replace "Degree: ", em(@harmonic_note.degree)
    @frequency_para.replace "Frequency: ", em(@harmonic_note.frequency)
    @octave_para.replace "Octave: ", em(@harmonic_note.octave)
    @octave_ratio_para.replace "Octave Ratio: ", em(@harmonic_note.octave_ratio)
    @octave_frequency_para.replace "Octave Frequency: ", em(@harmonic_note.octave_frequency)
  end
  base_frequency, degree = 528, 1
  stack margin: 30 do
    stack margin: 10 do
      title "The Baffled King"
    end
    stack margin: 10 do
      para "Base frequency: "
      @base_frequency = edit_line(base_frequency)
    end
    stack margin: 10 do
      para "Degree: "
      @degree = edit_line(degree)
    end
    stack margin: 10 do
      button("Compose Hallelujah") do
        refresh_results
      end
    end
  end
  @base_note = Ceely::Note.new(@base_frequency.text.to_i)
  @harmonic_note = Ceely::HarmonicNote.new(@base_note, @degree.text.to_i)
  stack margin: 30 do
    stack margin: 10 do
      para ins("Results")
    end
    stack margin: 10 do
      @degree_para = para ""
    end
    stack margin: 10 do
      @frequency_para = para ""
    end
    stack margin: 10 do
      @octave_para = para ""
    end
    stack margin: 10 do
      @octave_ratio_para = para ""
    end
    stack margin: 10 do
      @octave_frequency_para = para ""
    end
    refresh_results
  end
end
