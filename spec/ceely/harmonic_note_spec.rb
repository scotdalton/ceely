require 'spec_helper'
module Ceely
  describe HarmonicNote do
    harmonic_notes.each do |relation, expected_values|
      context "when it's the #{relation} related harmonic," do
        subject(:harmonic_note) { HarmonicNote.new(Note.new(528), relation) }

        describe '#frequency' do
          expected_frequency = expected_values["frequency"]
          it 'has the frequency that we expect' do
            expect(harmonic_note.frequency).to eq(expected_frequency)
          end
        end

        describe '#octave' do
          it 'is the first octave' do
            expected_octave = expected_values["octave"]
            expect(harmonic_note.octave).to eq(expected_octave)
          end
        end

        describe '#interval_factor' do
          expected_interval_factor = expected_values["interval_factor"]
          it 'has the fundamental ratio we expect' do
            expect(harmonic_note.interval_factor).to eq(Rational(relation, 1))
            expect(harmonic_note.interval_factor.to_s).to eq(expected_interval_factor)
          end
        end

        describe '#octave_ratio' do
          it 'has the octave_ratio we expect' do
            expected_octave_denominator = expected_values["octave_denominator"]
            expected_octave_ratio = expected_values["octave_ratio"]
            # Should be degree/ratio_denominator
            expect(harmonic_note.octave_ratio).to eq(Rational(relation, expected_octave_denominator))
            expect(harmonic_note.octave_ratio.to_s).to eq(expected_octave_ratio)
          end
        end

        describe '#octave_frequency' do
          expected_octave_frequency = expected_values["octave_frequency"]
          it 'has the octave_frequency that we expect' do
            expect(harmonic_note.octave_frequency).to eq(expected_octave_frequency)
          end
        end
      end
    end
  end
end
