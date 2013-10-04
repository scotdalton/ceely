require 'spec_helper'
module Ceely
  describe Ceely::Scale do
    subject(:scale) { Ceely::Scale.new(528.0, 3) }

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

    describe '#mode_size' do
      it 'has the mode_size we expect' do
        expect(scale.mode_size).to eq(8)
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

    describe '#sort_notes' do
      it 'raises a NotImplementedError' do
        expect{ scale.sort_notes }.to raise_error(NotImplementedError)
      end
    end

    describe '#play' do
      it 'raises a NotImplementedError' do
        expect{ scale.play(1, 50) }.to raise_error(NotImplementedError)
      end
    end

    describe '#to_s' do
      it 'raises a NotImplementedError' do
        expect{ scale.to_s }.to raise_error(NotImplementedError)
      end
    end
  end
end
