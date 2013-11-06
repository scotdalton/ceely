$: <<  File.dirname(__FILE__)+'/../lib'
require 'ceely'
Shoes.app width: 800, height: 800, title: "Ceely" do
  background darkgray
  border black
  @semaphore = Mutex.new

  def white_key(position, note)
    Ceely::Gui::WhiteKey.new(self, position, note)
  end

  def black_key(position, note)
    Ceely::Gui::BlackKey.new(self, position, note)
  end

  def scale()
    Ceely::Scales::Ptolemaic::Scale.new
  end

  strokewidth 1
  @keys = scale.sort.each_with_index.collect do |note, index|
    (scale.naturals.include?(note)) ? 
      white_key(index, note) : black_key(index, note)
  end

  def play_song(song)
    start = 0.1
    song.playables.each do |playable|
      # Inactivate after the playable has played
      stop = start + playable.duration
      if playable.is_a?(Ceely::Note)
        key = @keys.find{ |key| key.note.name.eql?(playable.name) }
        timer(start) do 
          key.press
          Thread.new { playable.play(50) }
        end
        timer(stop) { key.release }
      elsif playable.is_a?(Ceely::Pause)
        timer(start) { playable.play(50) }
      elsif playable.is_a?(Ceely::Chord)
        playable.notes.each do |note|
          key = @keys.find{ |key| key.note.name.eql?(playable.name) }
          timer(start) do 
            key.press
            Thread.new { note.play(50) }
          end
          timer(stop) { key.release }
        end
      end
      start = stop + 0.1
    end
  end

  button("Play Mary Had a Little Lamb") do
    play_song(Ceely::SongBook::MaryHadALittleLamb.new(@scale))
  end

  button("Play Row, Row, Row Your Boat") do
    play_song(Ceely::SongBook::RowRowRowYourBoat.new(@scale))
  end
end