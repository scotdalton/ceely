$: <<  File.dirname(__FILE__)+'/../lib'
require 'ceely'
width = 1600
Shoes.app width: width, height: 600, title: "Final" do
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
    @keyboard ||= Ceely::Gui::Keyboard.new(self, selected_scale, 2,
      { width: width, top: 70, left: 20, height: 500 })
  end

  def beat_wheel
    @beat_wheel ||= Ceely::BeatWheel.new(1)
  end

  def song
    Ceely::RandomSongGenerator.new(selected_scale, 0.5, 5).song
  end

  def play_song
    timer(0) { @random.state = "disabled" }
    beat_thread = Thread.new { beat_wheel.rotate!(5).jam(5, 50) } if @funky.checked?
    song = self.song
    keyboard.play_song(song, 50)
    timer(song.duration + 0.5) do
      beat_thread.kill if @funky.checked?
      @random.state = nil
    end
  end

  def record
    keyboard.record = true
    @record.state = "disabled"
    @stop.state = nil
  end

  def stop
    keyboard.record = false
    @record.state = nil
    @stop.state = "disabled"
  end

  def playback
    timer(0) { @playback.state = "disabled" }
    beat_thread = Thread.new { beat_wheel.rotate!(5).jam(5, 50) } if @funky.checked?
    song = keyboard.recorded_song
    keyboard.playback(50)
    timer(song.duration + 0.5) do
      beat_thread.kill if @funky.checked?
      @playback.state = nil
    end
  end

  flow margin: 10 do
    para "Choose the scale: "
    @scales = list_box(items: SCALES) { refresh_keyboard }
  end

  flow margin: 10 do
    @funky = Ceely::Gui::LabeledCheck.new(self, "Make it funky")
  end

  flow margin: 10 do
    @random = button("Play a Random Song") { play_song }
    @record = button("Record") { record }
    @stop = button("Stop") { stop }
    @playback = button("Playback") { playback }
    # Initialize to a stopped state
    stop
  end

  @keyboard_flow = flow do
    validate
    keyboard
  end
end
