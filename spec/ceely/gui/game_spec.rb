require 'spec_helper'
module Ceely
  module Gui
    describe Ceely::Gui::Game do
      fake_shoes = FakeShoes.new
      subject(:game) { Ceely::Gui::Game.new(fake_shoes, { width: 1150 }) }
      describe '#width' do
        it "should be 1150" do
          expect(game.width).to be(1150)
        end
      end
    end
  end
end