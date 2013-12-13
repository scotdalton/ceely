require 'spec_helper'
module Ceely
  describe Ceely::Scale do
    subject(:scale) { Ceely::Scale.new(528.0, nil, 3) }

    describe '#fundamental_frequency' do
      it 'has the fundamental frequency that we expect' do
        expect(scale.fundamental_frequency).to eq(528.0)
      end
    end

    describe '#size' do
      it 'has the size we expect' do
        expect(scale.size).to eq(3)
      end
    end

    describe '#offset' do
      it 'has the offset we expect' do
        expect(scale.offset).to eq(0)
      end
    end

    describe '#notes' do
      it 'is an Array' do
        expect(scale.notes).to be_a(Array)
      end

      it 'has the expected size' do
        expect(scale.notes.size).to eq(3)
      end
    end

    describe '#sorted_notes' do
      it 'should raise a NotImplementedError' do
        expect{ scale.sorted_notes }.to raise_error(NotImplementedError)
      end
    end

    describe '#sort' do
      it 'should raise a NotImplementedError' do
        expect{ scale.sort }.to raise_error(NotImplementedError)
      end
    end

    describe '#note_names' do
      it 'is an Array' do
        expect(scale.note_names).to be_a(Array)
      end

      it 'is empty' do
        expect(scale.note_names).to be_empty
      end
    end

    describe '#play' do
      it 'should raise a NotImplementedError' do
        expect{ scale.play(50) }.to raise_error(NotImplementedError)
      end
    end

    describe '#play_circle_of_fifths' do
      it 'should raise a NotImplementedError' do
        expect{ scale.play_circle_of_fifths(50) }.to raise_error(NotImplementedError)
      end
    end

    describe '#play_circle_of_fifths_in_octave' do
      it 'should raise a NotImplementedError' do
        expect{ scale.play_circle_of_fifths_in_octave(1, 50) }.to raise_error(NotImplementedError)
      end
    end

    describe '#to_s' do
      it 'should raise a NotImplementedError' do
        expect{ scale.sorted_notes }.to raise_error(NotImplementedError)
      end
    end
  end
end
