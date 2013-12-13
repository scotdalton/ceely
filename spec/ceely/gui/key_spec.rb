require 'spec_helper'
module Ceely
  module Gui
    describe Ceely::Gui::Key do
      fake_shoes = FakeShoes.new
      scale = Ceely::Scales::Pythagorean::Scale.new
      c = scale.note_by_name("C")
      subject(:key) { Ceely::Gui::Key.new(fake_shoes, 0, c) }

      describe '#note' do
        it "should be a Pythagorean C" do
          expect(key.note).to be_an_instance_of(Ceely::Scales::Pythagorean::Note)
          expect(key.note.name).to eq("C")
          expect(key.note.frequency).to eq(528)
        end
      end

      describe '#position' do
        it "should be 0" do
          expect(key.position).to be(0)
        end
      end

      describe '#width' do
        it "should be 50" do
          expect(key.width).to be(50)
        end
      end

      describe '#height' do
        it "should be 50" do
          expect(key.height).to be(350)
        end
      end

      describe '#left' do
        it "should be 50" do
          expect(key.left).to be(50)
        end
      end

      describe '#top' do
        it "should be 50" do
          expect(key.top).to be(50)
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

      describe '#active_fill' do
        it "should be darkgray" do
          expect(key.active_fill).to eq("Fake darkgray")
        end
      end

      describe '#inactive_fill' do
        it "should be white" do
          expect(key.inactive_fill).to eq("Fake white")
        end
      end
    end
  end
end