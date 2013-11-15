$: <<  File.dirname(__FILE__)+'/../lib'
require 'ceely'
Shoes.app width: 800, height: 800, title: "Ceely" do
  background darkgray
  border black

  def scale()
    Ceely::Scales::Ptolemaic::Scale.new
  end

  @keyboard = Ceely::Gui::Keyboard.new(self, scale)

  button("Play Mary Had a Little Lamb") do
    @keyboard.play_song(Ceely::SongBook::MaryHadALittleLamb.new(scale))
  end

  button("Play Row, Row, Row Your Boat") do
    @keyboard.play_song(Ceely::SongBook::RowRowRowYourBoat.new(scale))
  end
end