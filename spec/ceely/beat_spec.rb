require 'spec_helper'
module Ceely
  describe Ceely::Beat do
    subject(:beat) { Ceely::Beat.new(0.5) }

    describe '#duration' do
      it 'has the duration we expect' do
        expect(beat.duration).to eq(0.5)
      end
    end

    describe '#noise' do
      it 'raises a NotImplementedError' do
        expect{ beat.noise }.to raise_error(NotImplementedError)
      end
    end

    describe '#play' do
      it 'raises a NotImplementedError' do
        expect{ beat.play(50) }.to raise_error(NotImplementedError)
      end
    end
  end
end
