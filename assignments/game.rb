$: <<  File.dirname(__FILE__)+'/../lib'
require 'ceely'
width = 1150
Shoes.app width: width, height: 700, title: "Final" do
  background darkgray
  @game = Ceely::Gui::Game.new(self, { width: width })
end