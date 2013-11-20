$: <<  File.dirname(__FILE__)+'/../lib'
require 'ceely'
INDEXES = %w{ -6 -5 -4 -3 -2 -1 0 1 2 3 4 5 6 7 8 9 10 }
SCALES = %w{ Meantone Zarlino Harmonic Pythagorean Dodecaphonic Ptolemaic EvenTempered }
Ceely::Gui::Assignment.new("Assignment 10", 800, 800).run do

  def refresh_results
    @index.choose("1") if @index.text.blank?
    @scale = Ceely::Scales::Meantone::Scale.new(@fundamental_frequency.text.to_f)
    @note = @scale.sort.find { |note| note.index.eql? @index.text.to_i }
    @index_para.replace "Index: ", em(@note.index)
    @octave_adjusted_factor_para.replace "Octave Adjusted Factor: ", em(@note.octave_adjusted_factor)
    @frequency_para.replace "Frequency: ", em(@note.frequency)
    @name_para.replace "Name: ", em(@note.name)
    @type_para.replace "Type: ", em(@note.type)
  end

  def refresh_song
    @scales.choose("Meantone") if @scales.text.blank?
  end

  fundamental_frequency, index  = 528, 1
  duration, amplitude = 0.5, 50
  flow width: 800, height: 750 do
    flow margin: 20, width: 400, height: 250 do
      background lightgray, curve: 20
      border darkred, curve: 20, strokewidth: 1
      stack margin: 10 do
        subtitle "Meantone Scale"
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
        button("Play the Meantone Scale") do
          refresh_results
          amplitude = @amplitude.text.to_i
          duration = @duration.text.to_f
          @scale.duration = @duration.text.to_f
          song = Ceely::SongBook::Scale.new(@scale, duration)
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
    flow margin: 20, width: 400, height: 550 do
      background lightgray, curve: 20
      border darkred, curve: 20, strokewidth: 1
      stack margin: 10 do
        subtitle "Mary Had a Little Lamb"
      end
      flow margin: 10 do
        para "Choose the scale: "
        @scales = list_box items: SCALES, choose: "Meantone"
      end
      flow margin: 10 do
        para "Choose the fundamental frequency: "
        @fundamental_frequency = edit_line(528)
      end
      flow margin: 10 do
        para "Choose the seconds/beats: "
        @tempo = edit_line(0.5)
      end
      stack margin: 10 do
        button("Play the Song") do
          refresh_song
          fundamental_frequency = @fundamental_frequency.text.to_f
          scale = @scales.text
          tempo = @tempo.text.to_f
          key = "Ceely::Scales::#{scale}::Scale".safe_constantize.new(fundamental_frequency)
          song = Ceely::SongBook::MaryHadALittleLamb.new(key, tempo)
          Thread.new do
            song.play(50)
          end
        end
      end
      refresh_song
    end
  end
end
