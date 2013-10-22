require 'spec_helper'
module Ceely
  describe Ceely::NoteSet do
    subject(:note_set) { Ceely::NoteSet.new() }

    describe '#size' do
      it 'has the size we expect' do
        expect(note_set.size).to eq(0)
      end
    end

    describe '#notes' do
      it 'is an Array' do
        expect(note_set.notes).to be_a(Array)
      end

      it 'has the expected size' do
        expect(note_set.notes.size).to eq(0)
      end
    end

    describe '#sort' do
      it 'doesn\'t raise an error' do
        expect{ note_set.sort }.not_to raise_error
      end
    end

    describe '#play' do
      it 'doesn\'t raise an error' do
        expect{ note_set.play(1, 50) }.not_to raise_error
      end
    end

    describe '#to_s' do
      it 'doesn\'t raise an error' do
        expect{ note_set.to_s }.not_to raise_error
      end
    end
  end
end
