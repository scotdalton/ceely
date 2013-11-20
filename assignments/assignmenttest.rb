$: <<  File.dirname(__FILE__)+'/../lib'
require 'ceely'
width = 1800
Shoes.app width: width, height: 500, title: "Ceely" do
  background darkgray
  border black

  def scale()
    Ceely::Scales::Meantone::Scale.new
  end

  @keyboard = Ceely::Gui::Keyboard.new(self, scale, 2, { width: width })

  button("Play Mary Had a Little Lamb", { left: 20, top: 20 }) do
    @keyboard.play_song(Ceely::SongBook::MaryHadALittleLamb.new(scale, 0.5), 50)
  end
end