require 'spec_helper'
module Ceely
  module Interval
    describe Base do
      subject(:interval) { Base.new(Note.new(528.0), 2) }

      describe '#frequency' do
        it 'raises a NotImplementedError' do
          expect{ interval.frequency }.to raise_error(NotImplementedError)
        end
      end

      describe '#factor' do
        it 'raises a NotImplementedError' do
          expect{ interval.factor }.to raise_error(NotImplementedError)
        end
      end

      describe '#octave' do
        it 'has the octave we expect' do
          expect{ interval.octave }.to raise_error(NotImplementedError)
        end
      end

      describe '#octave_adjusted_denominator' do
        it 'raises a NotImplementedError' do
          expect{ interval.octave_adjusted_denominator }.to raise_error(NotImplementedError)
        end
      end

      describe '#octave_adjusted_factor' do
        it 'raises a NotImplementedError' do
          expect{ interval.octave_adjusted_factor }.to raise_error(NotImplementedError)
        end
      end

      describe '#octave_adjusted_frequency' do
        it 'raises a NotImplementedError' do
          expect{ interval.octave_adjusted_frequency }.to raise_error(NotImplementedError)
        end
      end

      describe '#octave_adjusted_note' do
        it 'raises a NotImplementedError' do
          expect{ interval.octave_adjusted_note }.to raise_error(NotImplementedError)
        end
      end

      describe '#to_s' do
        it 'raises a NotImplementedError' do
          expect{ interval.to_s }.to raise_error(NotImplementedError)
        end
      end
    end
  end
end
