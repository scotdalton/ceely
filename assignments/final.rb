$: <<  File.dirname(__FILE__)+'/../lib'
require 'ceely'
class Final < Shoes

  cattr_reader :scale, :song, instance_reader: false
  
  SCALES = %w{ Meantone Zarlino Harmonic Pythagorean Dodecaphonic Ptolemaic EvenTempered }

  url '/', :index
  url '/keyboard', :keyboard

  def validate
    @scales.choose("EvenTempered") if @scales.text.blank?
  end

  def control_panel
    @controls = []
    flow(margin: 10) do
      @controls << para("Choose the scale: ")
      @controls << @scales = list_box(items: SCALES, choose: "EvenTempered")
    end
    flow(margin: 10) do
      @controls << para("Choose the fundamental frequency: ")
      @controls << @fundamental_frequency = edit_line(528).text
    end
    flow(margin: 10) do
      @controls << para("Choose the seconds/beats: ")
      @controls << @tempo = edit_line(0.5).text
    end
  end

  def keyboard
    @keyboard = Ceely::Gui::Keyboard.new(self, self.class.scale, 2, {width: 1800})
    song = self.class.song
    @keyboard.play_song(song, 50)
      timer(song.duration + 2) { visit "/" }
  end

  def index
    fundamental_frequency, index  = 528, 1
    duration, amplitude = 0.5, 50
    flow(height: 500) do
      background lightgray, curve: 20
      border darkred, curve: 20, strokewidth: 1
      stack margin: 10 do
        subtitle "Mary Had a Little Lamb"
      end
      control_panel
      stack margin: 10 do
        button("Play the Song") do
          validate
          fundamental_frequency = @fundamental_frequency.to_f
          tempo = @tempo.to_f
          scale = @scales.text
          @@scale =
            "Ceely::Scales::#{scale}::Scale".safe_constantize.new(fundamental_frequency)
          @@song = Ceely::SongBook::MaryHadALittleLamb.new(self.class.scale, tempo)
          visit "/keyboard"
        end
      end
    end
    validate
  end
end

Shoes.app :width => 1800, :height => 1000, :title => 'Final'
