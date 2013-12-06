$: <<  File.dirname(__FILE__)+'/../lib'
require 'ceely'
TYPES = %w{ 1 M2 M3 4 5 M6 M7 }
SCALES = %w{ Meantone Zarlino Harmonic Pythagorean Dodecaphonic Ptolemaic EvenTempered }
Ceely::Gui::Assignment.new("Assignment 11", 800, 800).run do

  def refresh
    @type.choose("1") if @type.text.blank?
    @scale = Ceely::Scales::Rameau::Scale.new(@fundamental_frequency.text.to_f)
    @note = @scale.note_by_type(@type.text)
    @octave_adjusted_factor_para.replace "Octave Adjusted Factor: ", em(@note.octave_adjusted_factor)
    @frequency_para.replace "Frequency: ", em(@note.frequency)
    @name_para.replace "Name: ", em(@note.name)
    @type_para.replace "Type: ", em(@note.type)
  end

  fundamental_frequency, index  = 528, 1
  duration, amplitude = 0.5, 50
  flow width: 800, height: 750 do
    flow margin: 20, width: 400, height: 400 do
      background lightgray, curve: 20
      border darkred, curve: 20, strokewidth: 1
      stack margin: 10 do
        subtitle "Rameau Scale"
      end
      stack margin: 10 do
        para "Base Frequency: "
        @fundamental_frequency = edit_line(fundamental_frequency)
      end
      stack margin: 10 do
        para "Type: "
        @type = list_box items: TYPES, choose: "1" do |list|
          refresh
        end
      end
      stack margin: 10 do
        button("Refresh the Stats") do
          refresh
        end
      end
    end
    flow margin: 20, width: 400, height: 400 do
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
        button("Play the Rameau Scale") do
          refresh
          amplitude = @amplitude.text.to_i
          duration = @duration.text.to_f
          scale = @scale
          Thread.new do
            scale.duration = duration
            song = Ceely::SongBook::Scale.new(scale, duration)
            song.play(amplitude) 
          end
        end
      end
      stack margin: 10 do
        button("Play the Circle of Fifths' Sharps") do
          refresh
          amplitude = @amplitude.text.to_i
          duration = @duration.text.to_f
          scale = @scale
          Thread.new do
            scale.duration = duration
            song = Ceely::SongBook::Scale.new(scale, duration)
            song.play(amplitude) 
            6.times do |index|
              p index
              scale = scale.sharpen
              song = Ceely::SongBook::Scale.new(scale, duration)
              song.play(amplitude)
            end
          end
        end
      end
      stack margin: 10 do
        button("Play the Circle of Fifths' Flats") do
          refresh
          amplitude = @amplitude.text.to_i
          duration = @duration.text.to_f
          scale = @scale
          Thread.new do
            scale.duration = duration
            song = Ceely::SongBook::Scale.new(scale, duration)
            song.play(amplitude)
            6.times do |index|
              scale = scale.flatten
              song = Ceely::SongBook::Scale.new(scale, duration)
              song.play(amplitude)
            end
          end
        end
      end
    end
    flow margin: 20, width: 800, height: 400 do
      background lightgray, curve: 20
      border darkred, curve: 20, strokewidth: 1
      flow margin: 10 do
        subtitle("The Stats")
      end
      flow margin: 10 do
        @cents_para = para ""
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
      refresh
    end
  end
end
