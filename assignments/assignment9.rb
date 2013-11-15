$: <<  File.dirname(__FILE__)+'/../lib'
require 'ceely'
INDEXES = %w{ 0 1 2 3 4 5 6 }
HARMONIES = %w{ Third Fourth Fifth }
SCALES = %w{ Zarlino Harmonic Pythagorean Dodecaphonic Ptolemaic EvenTempered }
Ceely::Gui::Assignment.new("Assignment 9", 800, 800).run do
  def refresh_results
    @index.choose("1") if @index.text.blank?
    @scale = Ceely::Scales::Zarlino::Scale.new(@fundamental_frequency.text.to_f)
    @note = @scale.sort.find { |note| note.index.eql? @index.text.to_i }
    @index_para.replace "Index: ", em(@note.index)
    @raw_frequency_para.replace "Raw Frequency: ", em(@note.raw_frequency)
    @octave_para.replace "Octave: ", em(@note.octave)
    @octave_adjusted_factor_para.replace "Octave Adjusted Factor: ", em(@note.octave_adjusted_factor)
    @frequency_para.replace "Frequency: ", em(@note.frequency)
    @name_para.replace "Name: ", em(@note.name)
    @type_para.replace "Type: ", em(@note.type)
  end
  def refresh_harmonize
    @harmonies.choose("Fourth") if @harmonies.text.blank?
    @harmony_song = case @harmonies.text
    when "Third"
      Ceely::SongBook::Harmonies3
    when "Fourth"
      Ceely::SongBook::Harmonies4
    when "Fifth"
      Ceely::SongBook::Harmonies5
    else
      Ceely::SongBook::Harmonies4
    end
    # Harmonize scales
    @harmonize_scales.first.checked = 
      true if @harmonize_scales.none? { |scale| scale.checked? }
    @scales = @harmonize_scales.collect do |scale|
      if scale.checked?
        label = scale.label
        "Ceely::Scales::#{label}::Scale".safe_constantize.new(@fundamental_frequency.text.to_f)
      end
    end
    @scales.compact!
  end
  fundamental_frequency, index  = 528, 1
  duration, amplitude = 0.5, 50
  flow width: 800, height: 750 do
    flow margin: 20, width: 400, height: 250 do
      background lightgray, curve: 20
      border darkred, curve: 20, strokewidth: 1
      stack margin: 10 do
        subtitle "Zarlino Scale"
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
    flow margin: 20, width: 400, height: 250 do
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
        button("Play Zarlino's Scale") do
          refresh_results
          amplitude = @amplitude.text.to_i
          @scale.duration = @duration.text.to_f
          song = Ceely::SongBook::Scale.new(@scale)
          Thread.new { song.play(amplitude) }
        end
      end
    end
    flow margin: 20, width: 400, height: 550 do
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
      flow margin: 10 do
        @keyboard_para = para ""
      end
      refresh_results
    end
    flow margin: 20, width: 400, height: 550 do
      background lightgray, curve: 20
      border darkred, curve: 20, strokewidth: 1
      flow margin: 10 do
        subtitle("Harmonize")
      end
      stack margin: 10 do
        para "Harmony: "
        @harmonies = list_box items: HARMONIES, choose: "Fourth" do |list|
          refresh_harmonize
        end
      end
      flow margin: 10 do
        @flatten = Ceely::Gui::LabeledCheck.new(self, "Flatten B")
      end
      flow margin: 10 do
        para "Choose the scale(s): "
        @harmonize_scales = []
        SCALES.each do |scale|
          @harmonize_scales << Ceely::Gui::LabeledCheck.new(self, scale)
        end
      end
      stack margin: 10 do
        para "Duration: "
        @harmonize_duration = edit_line(duration)
      end
      stack margin: 10 do
        para "Amplitude 1: "
        @harmonize_amplitude1 = edit_line(amplitude)
      end
      stack margin: 10 do
        para "Amplitude 2: "
        @harmonize_amplitude2 = edit_line(40)
      end
      stack margin: 10 do
        button("Play the Harmonies") do
          refresh_results
          refresh_harmonize
          amplitude1 = @harmonize_amplitude1.text.to_i
          amplitude2 = @harmonize_amplitude2.text.to_i
          duration = @harmonize_duration.text.to_f
          flatten = @flatten.checked?
          @scales.each do |scale|
            scale.duration = duration
            song = @harmony_song.new(flatten, scale, duration)
            Thread.new { song.play(amplitude1, amplitude2) }
          end
        end
      end
      refresh_harmonize
    end
  end
end
