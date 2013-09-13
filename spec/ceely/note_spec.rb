require 'spec_helper'
module Ceely
  describe Note do
    subject(:note) { Note.new(67, Instrument.new(8, 81, 'soundbank-deluxe')) }

    describe '#pitch' do
      it 'has the pitch that we expect' do
        expect(note.pitch).to eq(67)
      end
    end

    describe '#play' do
      context 'when no block is given' do
        it 'plays without errors' do
          expect { note.play }.not_to raise_error
        end
      end

      context 'when a 5 second sleep block is given' do
        it 'plays for 5 seconds' do
          expect { note.play { sleep 5 } }.not_to raise_error
        end
      end
    end
  end
end
