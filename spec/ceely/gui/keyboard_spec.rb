require 'spec_helper'
module Ceely
  module Gui
    describe Ceely::Gui::Keyboard do
      fake_shoes = FakeShoes.new
      scale = Ceely::Scales::Pythagorean::Scale.new
      subject(:key) { Ceely::Gui::Keyboard.new(fake_shoes, scale, 2,
        { width: 1600, top: 70, left: 20, height: 500 }) }

      describe '#width' do
        it "should be 1600" do
          expect(key.width).to be(1600)
        end
      end

      describe '#height' do
        it "should be 500" do
          expect(key.height).to be(500)
        end
      end

      describe '#left' do
        it "should be 50" do
          expect(key.left).to be(20)
        end
      end

      describe '#top' do
        it "should be 50" do
          expect(key.top).to be(70)
        end
      end

      describe '#show_names' do
        it "should be true" do
          expect(key.show_names).to be(true)
        end
      end

      describe '#show_names?' do
        it "should be true" do
          expect(key.show_names?).to be(true)
        end
      end

      describe '#press_keys' do
        it "should be true" do
          expect(key.press_keys).to be(true)
        end
      end

      describe '#press_keys?' do
        it "should be true" do
          expect(key.press_keys?).to be(true)
        end
      end

      describe '#record' do
        it "should be false" do
          expect(key.record).to be(false)
        end
      end

      describe '#record?' do
        it "should be false" do
          expect(key.record?).to be(false)
        end
      end
    end
  end
end