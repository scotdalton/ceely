require 'spec_helper'
module Ceely
  module Scale
    describe Pythagorean do

      # Set the expected values
      expected_display_notes = pythagoreans.collect { |index, expected_values|
        "Note with frequency #{expected_values["octave_adjusted_frequency"]}" 
      }.join("\n\n")

      subject(:pythagorean) { Pythagorean.new(Note.new(528.0), 13, -1) }

      describe '#fundamental' do
        it 'is a Note' do
          expect(pythagorean.fundamental).to be_a(Note)
        end

        it 'has the frequency that we expect' do
          expect(pythagorean.fundamental.frequency).to eq(528.0)
        end
      end

      describe '#size' do
        it 'has the size we expect' do
          expect(pythagorean.size).to eq(13)
        end
      end

      describe '#notes' do
        it 'is an Array' do
          expect(pythagorean.notes).to be_a(Array)
        end

        describe '#offset' do
          it 'has the offset we expect' do
            expect(pythagorean.offset).to eq(-1)
          end
        end

        it 'has the expected size' do
          expect(pythagorean.notes.size).to eq(14)
        end
      end

      # Don't run this test on travis since
      # we don't have permissions.
      unless(ENV['TRAVIS'].eql? "true")
        describe '#play' do
          it 'does not raises an error' do
            expect{ pythagorean.play(1, 50) }.not_to raise_error
          end
        end
      end

      describe '#to_s' do
        it 'does not raises an error' do
          expect{ pythagorean.to_s }.not_to raise_error
        end

        it 'displays the expected notes' do
          expect(pythagorean.to_s).to eql(expected_display_notes)
        end
      end
    end
  end
end
