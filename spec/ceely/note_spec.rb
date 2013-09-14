require 'spec_helper'
module Ceely
  describe Note do
    subject(:note) { Note.new(400) }

    describe '#frequency' do
      it 'has the frequency that we expect' do
        expect(note.frequency).to eq(400)
      end
    end

    describe '#play' do
      it 'plays for 5 seconds' do
        expect { note.play(5) }.not_to raise_error
      end
    end
  end
end
