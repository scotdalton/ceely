$: <<  File.dirname(__FILE__)+'/../lib'
require 'ceely'
SCALES = %w{ EvenTempered Pythagorean Dodecaphonic }
Ceely::Assignment.new("Final", 350, 375).run do
  def refresh()
    @scales.choose("EvenTempered") if @scales.text.blank?
  end

  fundamental_frequency, index  = 528, 1
  duration, amplitude = 0.5, 50
  flow width: 400, height: 425 do
    flow margin: 20, width: 350, height: 375 do
      background lightgray, curve: 20
      border darkred, curve: 20, strokewidth: 1
      stack margin: 10 do
        subtitle "Mary Had a Little Lamb"
      end
      flow margin: 10 do
        para "Choose the scale: "
        @scales = list_box items: SCALES, choose: "EvenTempered"
      end
      flow margin: 10 do
        para "Choose the fundamental frequency: "
        @fundamental_frequency = edit_line(528)
      end
      flow margin: 10 do
        para "Choose the seconds/beats: "
        @tempo = edit_line(1)
      end
      stack margin: 10 do
        button("Play the Song") do
          refresh
          fundamental_frequency = @fundamental_frequency.text.to_f
          scale = @scales.text
          key = "Ceely::#{scale}::Scale".safe_constantize.new(fundamental_frequency)
          tempo = @tempo.text.to_f
          song = Ceely::MaryHadALittleLamb.new(key, tempo)
          Thread.new do
            song.play(50)
          end
        end
      end
      stack margin: 10 do
        button("Stack 'em up") do
          songs = []
          SCALES.each do |scale|
            fundamental_frequency = @fundamental_frequency.text.to_f
            scale = @scales.text
            key = "Ceely::#{scale}::Scale".safe_constantize.new(fundamental_frequency)
            tempo = @tempo.text.to_f
            songs << Ceely::MaryHadALittleLamb.new(key, tempo)
          end
          songs.each do |song|
            Thread.new do
              song.play(50)
            end
          end
        end
      end
    end
    refresh
  end
end
