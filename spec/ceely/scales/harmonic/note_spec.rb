require 'spec_helper'
module Ceely
  module Scales
    module Harmonic
      describe Ceely::Scales::Harmonic::Note do
        harmonics["notes"].each do |index, expected_values|

          # Set the expected values
          expected_fundamental_frequency = 528.0
          expected_factor = expected_values["factor"]
          expected_factor_array = expected_factor.split("/")
          expected_factor_num = expected_factor_array.first
          expected_factor_den = expected_factor_array.last
          expected_raw_frequency = expected_values["raw_frequency"]
          expected_raw_octave = expected_values["raw_octave"]
          expected_octave_adjusted_denominator = expected_values["octave_adjusted_denominator"]
          expected_octave_adjusted_factor = expected_values["octave_adjusted_factor"]
          expected_frequency = expected_values["frequency"]
          expected_cents = expected_values["cents"]

          context "when it's the #{index} note note," do
            subject(:scale) { Ceely::Scales::Harmonic::Scale.new(528.0) }
            subject(:note) { scale.note_by_index(index) }

            describe '#index' do
              it 'has the index that we expect' do
                expect(note.index).to eq(index)
              end
            end

            describe '#raw_frequency' do
              it 'has the raw frequency that we expect' do
                expect(note.raw_frequency).to eq(expected_raw_frequency)
              end
            end

            describe '#factor' do
              it 'has the factor we expect' do
                expect(note.factor).to be_a(Rational)
                expect(note.factor).to eq(Rational(expected_factor_num, expected_factor_den))
                expect("#{note.factor}").to eq(expected_factor)
              end
            end

            describe '#raw_tone' do
              it 'has the raw tone that we expect' do
                expect(note.raw_tone).to eq(Tone.new(expected_raw_frequency, 0.5))
              end
            end

            describe '#raw_octave' do
              it 'has #{expected_raw_octave} as the raw octave' do
                expect(note.raw_octave).to eq(expected_raw_octave)
              end
            end

            describe '#octave_adjusted_denominator' do
              it 'is the octave denominator we expect' do
                expect(note.octave_adjusted_denominator).to eq(expected_octave_adjusted_denominator)
              end
            end

            describe '#octave_adjusted_factor' do
              it 'has the octave_adjusted_factor we expect' do
                expect(note.octave_adjusted_factor).to eq(Rational(expected_octave_adjusted_factor))
                expect("#{note.octave_adjusted_factor}").to eq(expected_octave_adjusted_factor)
              end
            end

            describe '#frequency' do
              it 'has the frequency that we expect' do
                expect(note.frequency).to eq(expected_frequency)
              end
            end

            describe '#tone' do
              it 'has the tone that we expect' do
                expect(note.tone).to eq(Tone.new(expected_frequency, 0.5))
              end
            end

            describe '#cents' do
              it 'has the cents that we expect' do
                expect(note.cents).to be_within(0.5).of(expected_cents)
              end
            end

            describe '#to_s' do
              it 'does not raises an error' do
                expect{ note.to_s }.not_to raise_error
              end
            end
          end
        end
      end
    end
  end
end
