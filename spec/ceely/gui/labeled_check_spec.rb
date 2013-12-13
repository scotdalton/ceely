require 'spec_helper'
module Ceely
  module Gui
    describe Ceely::Gui::Keyboard do
      fake_shoes = FakeShoes.new
      subject(:key) { Ceely::Gui::LabeledCheck.new(fake_shoes, "Label") }

      describe '#label' do
        it "should be 'Label'" do
          expect(key.label).to eql("Label")
        end
      end
    end
  end
end