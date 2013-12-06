$: <<  File.dirname(__FILE__)+'/../lib'
require 'ceely'
width = 1600
SCALES = %w{ Rameau Meantone Zarlino Pythagorean Dodecaphonic Ptolemaic EvenTempered }
DEFAULT_SCALE = SCALES.first
Shoes.app width: width, height: 600, title: "Mary Had a Little Lamb" do
  background darkgray
  border black

  def validate()
    @scales.choose(DEFAULT_SCALE) if @scales.text.blank? unless @scales.blank?
  end

  def selected_scale
    validate
    scale = @scales.text unless @scales.blank?
    scale ||= DEFAULT_SCALE
    "Ceely::Scales::#{scale}::Scale".safe_constantize.new
  end

  def refresh_keyboard
    @keyboard_flow.clear
    @keyboard.clear unless @keyboard.blank?
    @keyboard = nil
    validate
    timer(0) { @keyboard_flow.append{ keyboard } }
  end

  def keyboard
    @keyboard ||= 
      Ceely::Gui::Keyboard.new(self, selected_scale, 2, { width: width, top: 70, left: 20, height: 500 })
  end

  def beat_wheel
    @beat_wheel ||= Ceely::BeatWheel.new(1)
  end

  def song
    Ceely::SongBook::MaryHadALittleLamb.new(selected_scale, 0.5)
  end

  def play_song
    Thread.new { beat_wheel.rotate!(5).jam(10, 4) } if @funky.checked?
    keyboard.play_song(song, 50)
  end

  flow margin: 10 do
    para "Choose the scale: "
    @scales = list_box(items: SCALES) { refresh_keyboard }
  end

  flow margin: 10 do
    @funky = Ceely::Gui::LabeledCheck.new(self, "Make it funky")
  end

  flow margin: 10 do
    button("Play Mary Had a Little Lamb") { play_song }
  end

  @keyboard_flow = flow do
    validate
    keyboard
  end
end
