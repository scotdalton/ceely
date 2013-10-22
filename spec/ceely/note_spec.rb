require 'spec_helper'
module Ceely
  describe Ceely::Note do
    subject(:note) { Ceely::Note.new(528.0, 2, "A") }

    describe '#frequency' do
      it 'raises a NotImplementedError' do
        expect{ note.frequency }.to raise_error(NotImplementedError)
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

    describe '#octave' do
      it 'has the octave we expect' do
        expect{ note.octave }.to raise_error(NotImplementedError)
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

    describe '#octave_adjusted_frequency' do
      it 'raises a NotImplementedError' do
        expect{ note.octave_adjusted_frequency }.to raise_error(NotImplementedError)
      end
    end

    describe '#octave_adjusted_tone' do
      it 'raises a NotImplementedError' do
        expect{ note.octave_adjusted_tone }.to raise_error(NotImplementedError)
      end
    end

    describe '#to_s' do
      it 'raises a NotImplementedError' do
        expect{ note.to_s }.to raise_error(NotImplementedError)
      end
    end

    describe '#becomes' do
      it 'becomes a Pythagorean' do
        expect(note.becomes(Ceely::Pythagorean::Note)).to be_a(Ceely::Pythagorean::Note)
      end
    end
  end
end
