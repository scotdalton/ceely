require 'spec_helper'
module Ceely
  module Scale
    describe Harmonic do
      expected_display_notes = harmonics.collect { |degree, expected_values|
        %Q{
          Degree: #{degree}
          Fundamental Ratio: #{Rational(degree, 1)}
          Fundamental Frequency: 528.0
          Frequency: #{expected_values["frequency"]}
          Octave: #{expected_values["octave"]}
          Octave Denominator: #{expected_values["octave_denominator"]}
          Octave Ratio: #{Rational(degree, expected_values["octave_denominator"])}
          Octave Frequency: #{expected_values["octave_frequency"]}
        }.strip.gsub(/^\s*/, "\t") }.join("\n\n")

      subject(:harmonic) { Harmonic.new(Note::Base.new(528.0), 33) }

      describe '#fundamental' do
        it 'is a Note' do
          expect(harmonic.fundamental).to be_a(Note::Base)
        end

        it 'has the frequency that we expect' do
          expect(harmonic.fundamental.frequency).to eq(528.0)
        end
      end

      describe '#size' do
        it 'has the size we expect' do
          expect(harmonic.size).to eq(33)
        end
      end

      describe '#notes' do
        it 'is an Array' do
          expect(harmonic.notes).to be_a(Array)
        end
      end

      describe '#notes size' do
        it 'has the expected size' do
          expect(harmonic.notes.size).to eq(33)
        end
      end

      describe '#offset' do
        it 'has the offset we expect' do
          expect(harmonic.offset).to eq(0)
        end
      end

      # Don't run this test on travis since
      # we don't have permissions.
      unless(ENV['TRAVIS'].eql? "true")
        describe '#play' do
          it 'does not raises an error' do
            expect{ harmonic.play(1, 50) }.not_to raise_error
          end
        end
      end

      describe '#to_s' do
        it 'does not raises an error' do
          expect{ harmonic.to_s }.not_to raise_error
        end

        it 'displays the expected notes' do
          expect(harmonic.to_s).to eql(expected_display_notes)
        end
      end
    end
  end
end
