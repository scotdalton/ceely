require 'spec_helper'
module Ceely
  module Scales
    module Ptolemaic
      describe Ceely::Scales::Ptolemaic::Note do
        ptolemaic["notes"].each do |index, expected_values|
          # Set the expected values
          expected_fundamental_frequency = 528.0
          n = expected_values["octave_adjusted_numerator"].to_i
          d = expected_values["octave_adjusted_denominator"].to_i
          expected_octave_adjusted_factor = Rational(n, d) 
          expected_frequency = expected_values["frequency"]
          # expected_cents = expected_values["cents"]

          context "when it's the #{index} note note," do
            subject(:scale) { Ceely::Scales::Ptolemaic::Scale.new(528.0) }
            subject(:note) { scale.note_by_index(index) }

            describe '#index' do
              it 'has the index that we expect' do
                expect(note.index).to eq(index)
              end
            end

            describe '#syntonic_comma' do
              it 'has the syntonic comma' do
                expect(note.syntonic_comma).to eq(Rational(81, 80))
              end
            end

            describe '#diminished_fifth_factor' do
              it 'has the diminished fifth factor' do
                expect(note.diminished_fifth_factor).to eq(Rational(64, 45))
              end
            end

            describe '#octave_adjusted_factor' do
              it 'has the octave_adjusted_factor that we expect' do
                expect(note.octave_adjusted_factor).to eq(expected_octave_adjusted_factor)
              end
            end
          end
        end
      end
    end
  end
end
