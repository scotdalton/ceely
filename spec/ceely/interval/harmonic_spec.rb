require 'spec_helper'
module Ceely
  module Interval
    describe Harmonic do
      harmonics.each do |index, expected_values|

        # Set the expected values
        expected_fundamental_frequency = 528.0
        expected_factor = expected_values["factor"]
        expected_factor_array = expected_factor.split("/")
        expected_factor_num = expected_factor_array.first
        expected_factor_den = expected_factor_array.last
        expected_frequency = expected_values["frequency"]
        expected_octave = expected_values["octave"]
        expected_octave_adjusted_denominator = expected_values["octave_adjusted_denominator"]
        expected_octave_adjusted_factor = expected_values["octave_adjusted_factor"]
        expected_octave_adjusted_frequency = expected_values["octave_adjusted_frequency"]

        context "when it's the #{index} harmonic interval," do
          subject(:harmonic) { Harmonic.new(Note.new(528.0), index) }

          describe '#index' do
            it 'has the index that we expect' do
              expect(harmonic.index).to eq(index)
            end
          end

          describe '#frequency' do
            it 'has the frequency that we expect' do
              expect(harmonic.frequency).to eq(expected_frequency)
            end
          end

          describe '#factor' do
            it 'has the fundamental ratio we expect' do
              expect(harmonic.factor).to be_a(Rational)
              expect(harmonic.factor).to eq(Rational(expected_factor_num, expected_factor_den))
              expect("#{harmonic.factor}").to eq(expected_factor)
            end
          end

          describe '#note' do
            it 'has the note that we expect' do
              expect(harmonic.note).to eq(Note.new expected_frequency)
            end
          end

          describe '#octave' do
            it 'is the octave we expect' do
              expect(harmonic.octave).to eq(expected_octave)
            end
          end

          describe '#octave_adjusted_denominator' do
            it 'is the octave denominator we expect' do
              expect(harmonic.octave_adjusted_denominator).to eq(expected_octave_adjusted_denominator)
            end
          end

          describe '#octave_adjusted_factor' do
            it 'has the octave_adjusted_factor we expect' do
              expect(harmonic.octave_adjusted_factor).to eq(Rational(expected_octave_adjusted_factor))
              expect("#{harmonic.octave_adjusted_factor}").to eq(expected_octave_adjusted_factor)
            end
          end

          describe '#octave_adjusted_frequency' do
            it 'has the octave_adjusted_frequency that we expect' do
              expect(harmonic.octave_adjusted_frequency).to eq(expected_octave_adjusted_frequency)
            end
          end

          describe '#octave_adjusted_note' do
            it 'has the octave_adjusted_note that we expect' do
              expect(harmonic.octave_adjusted_note).to eq(Note.new expected_octave_adjusted_frequency)
            end
          end

          describe '#to_s' do
            it 'goes to string as we expect' do
              expect(harmonic.to_s).to eql(%Q{
                Index: #{index}
                Factor: #{expected_factor}
                Fundamental Frequency: #{expected_fundamental_frequency}
                Frequency: #{expected_frequency}
                Octave: #{expected_octave}
                Octave Adjusted Denominator: #{expected_octave_adjusted_denominator}
                Octave Adjusted Factor: #{expected_octave_adjusted_factor}
                Octave Adjusted Frequency: #{expected_octave_adjusted_frequency}
              }.strip.gsub(/^\s*/, "\t"))
            end
          end
        end
      end
    end
  end
end
