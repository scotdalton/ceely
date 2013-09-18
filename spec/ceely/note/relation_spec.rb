require 'spec_helper'
module Ceely
  module Note
    describe Relation do
      subject(:relation) { Relation.new(Note::Base.new(528.0), 2, 1) }

      describe '#frequency' do
        it 'has the frequency that we expect' do
          expect(relation.frequency).to eq(528.0)
        end
      end

      describe '#interval_factor' do
        it 'has the interval factor we expect' do
          expect(relation.interval_factor).to be_a(Rational)
          expect(relation.interval_factor).to eq(Rational(1, 1))
          expect(relation.interval_factor.to_s).to eq("1/1")
        end
      end

      describe '#fundamental_ratio' do
        it 'has the fundamental ratio we expect' do
          expect(relation.interval_factor).to be_a(Rational)
          expect(relation.fundamental_ratio).to eq(Rational(1, 1))
          expect(relation.fundamental_ratio.to_s).to eq("1/1")
        end
      end

      describe '#octave' do
        it 'raises a NotImplementedError' do
          expect{ relation.octave }.to raise_error(NotImplementedError)
        end
      end

      describe '#octave_denominator' do
        it 'raises a NotImplementedError' do
          expect{ relation.octave_denominator }.to raise_error(NotImplementedError)
        end
      end

      describe '#octave_ratio' do
        it 'raises a NotImplementedError' do
          expect{ relation.octave_ratio }.to raise_error(NotImplementedError)
        end
      end

      describe '#octave_frequency' do
        it 'raises a NotImplementedError' do
          expect{ relation.octave_frequency }.to raise_error(NotImplementedError)
        end
      end

      describe '#to_s' do
        it 'goes to string as we expect' do
          expect(relation.to_s).to eql(%Q{
            Relation: 2
            Fundamental Ratio: 1/1
            Fundamental Frequency: 528.0
            Frequency: 528.0
          }.strip.gsub(/^\s*/, "\t"))
        end
      end
    end
  end
end
