require 'spec_helper'
module Ceely
  describe Ceely::Note do
    subject(:note) { Ceely::Note.new(528.0, 2, 0, "A") }

    describe '#raw_frequency' do
      it 'raises a NotImplementedError' do
        expect{ note.raw_frequency }.to raise_error(NotImplementedError)
      end
    end

    describe '#index' do
      it 'has the index we expect' do
        expect(note.index).to eq(2)
      end
    end

    describe '#name' do
      it 'has the name we expect' do
        expect(note.name).to eq("A")
      end
    end

    describe '#duration' do
      it 'has the duration we expect' do
        expect(note.duration).to eq(0.5)
      end
    end

    describe '#factor' do
      it 'raises a NotImplementedError' do
        expect{ note.factor }.to raise_error(NotImplementedError)
      end
    end

    describe '#raw_octave' do
      it 'has the octave we expect' do
        expect{ expect(note.raw_octave) }.to raise_error(NotImplementedError)
      end
    end

    describe '#octave_adjusted_denominator' do
      it 'raises a NotImplementedError' do
        expect{ note.octave_adjusted_denominator }.to raise_error(NotImplementedError)
      end
    end

    describe '#octave_adjusted_factor' do
      it 'raises a NotImplementedError' do
        expect{ note.octave_adjusted_factor }.to raise_error(NotImplementedError)
      end
    end

    describe '#frequency' do
      it 'raises a NotImplementedError' do
        expect{ note.frequency }.to raise_error(NotImplementedError)
      end
    end

    describe '#tone' do
      it 'raises a NotImplementedError' do
        expect{ note.tone }.to raise_error(NotImplementedError)
      end
    end

    describe '#play' do
      it 'raises a NotImplementedError' do
        expect{ note.play(50) }.to raise_error(NotImplementedError)
      end
    end

    describe '#to_s' do
      it 'does not raises an error' do
        expect{ note.to_s }.not_to raise_error
      end
    end

    describe '#becomes' do
      it 'becomes a Pythagorean' do
        expect(note.becomes(Ceely::Scales::Pythagorean::Note)).to be_a(Ceely::Scales::Pythagorean::Note)
      end
    end
  end
end
