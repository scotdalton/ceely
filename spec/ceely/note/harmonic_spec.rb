require 'spec_helper'
module Ceely
  module Note
    describe Harmonic do
      harmonics.each do |degree, expected_values|
        context "when it's the #{degree} related harmonic," do
          subject(:harmonic) { Harmonic.new(Note::Base.new(528.0), degree) }

          describe '#frequency' do
            it 'has the frequency that we expect' do
              expected_frequency = expected_values["frequency"]
              expect(harmonic.frequency).to eq(expected_frequency)
            end
          end

          describe '#interval_factor' do
            it 'has the fundamental ratio we expect' do
              expect(harmonic.interval_factor).to be_a(Rational)
              expect(harmonic.interval_factor).to eq(Rational(degree, 1))
              expected_interval_factor = expected_values["interval_factor"]
              expect(harmonic.interval_factor.to_s).to eq(expected_interval_factor)
            end
          end

          describe '#fundamental_ratio' do
            it 'has the fundamental ratio we expect' do
              expect(harmonic.interval_factor).to be_a(Rational)
              expect(harmonic.fundamental_ratio).to eq(Rational(degree, 1))
              expected_fundamental_ratio = expected_values["interval_factor"]
              expect(harmonic.fundamental_ratio.to_s).to eq(expected_fundamental_ratio)
            end
          end

          describe '#octave' do
            it 'is the octave we expect' do
              expected_octave = expected_values["octave"]
              expect(harmonic.octave).to eq(expected_octave)
            end
          end

          describe '#octave_denominator' do
            it 'is the octave denominator we expect' do
              expected_octave_denominator = expected_values["octave_denominator"]
              expect(harmonic.octave_denominator).to eq(expected_octave_denominator)
            end
          end

          describe '#octave_ratio' do
            it 'has the octave_ratio we expect' do
              expected_octave_denominator = expected_values["octave_denominator"]
              # Should be degree/ratio_denominator
              expect(harmonic.octave_ratio).to eq(Rational(degree, expected_octave_denominator))
              expected_octave_ratio = expected_values["octave_ratio"]
              expect(harmonic.octave_ratio.to_s).to eq(expected_octave_ratio)
            end
          end

          describe '#octave_frequency' do
            it 'has the octave_frequency that we expect' do
              expected_octave_frequency = expected_values["octave_frequency"]
              expect(harmonic.octave_frequency).to eq(expected_octave_frequency)
            end
          end

          describe '#to_s' do
            it 'goes to string as we expect' do
              expect(harmonic.to_s).to eql(%Q{
                Degree: #{degree}
                Fundamental Ratio: #{Rational(degree, 1)}
                Fundamental Frequency: 528.0
                Frequency: #{expected_values["frequency"]}
                Octave: #{expected_values["octave"]}
                Octave Denominator: #{expected_values["octave_denominator"]}
                Octave Ratio: #{Rational(degree, expected_values["octave_denominator"])}
                Octave Frequency: #{expected_values["octave_frequency"]}
              }.strip.gsub(/^\s*/, "\t"))
            end
          end
        end
      end
    end
  end
end
