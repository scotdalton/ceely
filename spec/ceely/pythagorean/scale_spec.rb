require 'spec_helper'
module Ceely
  module Pythagorean
    describe Ceely::Pythagorean::Scale do
      # Set the expected values
      expected_display_tones = pythagoreans.collect { |index, expected_values|
        "Tone with frequency #{expected_values["octave_adjusted_frequency"]}" 
      }.join("\n\n")

      context 'when constructed with defaults,' do
        subject(:scale) { Ceely::Pythagorean::Scale.new }

        describe '#fundamental_frequency' do
          it 'has the fundamental frequency that we expect' do
            expect(scale.fundamental_frequency).to eq(528.0)
          end
        end

        describe '#note_name' do
          it 'has the note name for the index' do
            expect(scale.note_name(-7)).to eq("C")
            expect(scale.note_name(-6)).to eq("D")
            expect(scale.note_name(-5)).to eq("E")
            expect(scale.note_name(-4)).to eq("F")
            expect(scale.note_name(-3)).to eq("G")
            expect(scale.note_name(-2)).to eq("A")
            expect(scale.note_name(-1)).to eq("B")
            expect(scale.note_name(0)).to eq("C")
            expect(scale.note_name(1)).to eq("D")
            expect(scale.note_name(2)).to eq("E")
            expect(scale.note_name(3)).to eq("F")
            expect(scale.note_name(4)).to eq("G")
            expect(scale.note_name(5)).to eq("A")
            expect(scale.note_name(6)).to eq("B")
            expect(scale.note_name(7)).to eq("C")
          end
        end

        describe '#size' do
          it 'has the size we expect' do
            expect(scale.size).to eq(7)
          end
        end

        describe '#notes' do
          it 'is an Array' do
            expect(scale.notes).to be_a(Array)
          end

          it 'has the expected size' do
            expect(scale.notes.size).to eq(7)
          end
        end

        describe '#tones' do
          it 'is an Array' do
            expect(scale.tones).to be_a(Array)
          end

          it 'has the expected size' do
            expect(scale.tones.size).to eq(7)
          end
        end

        describe '#offset' do
          it 'has the offset we expect' do
            expect(scale.offset).to eq(-1)
          end
        end

        # Don't run this test on travis since
        # we don't have permissions.
        unless(ENV['TRAVIS'].eql? "true")
          describe '#play' do
            it 'does not raises an error' do
              expect{ scale.play(1, 50) }.not_to raise_error
            end
          end
        end

        describe '#to_s' do
          it 'does not raises an error' do
            expect{ scale.to_s }.not_to raise_error
          end

          # it 'displays the expected tones' do
          #   expect(scale.to_s).to eql(expected_display_tones)
          # end
        end
      end

      context 'when constructed with inputs,' do
        subject(:scale) { Ceely::Pythagorean::Scale.new(594.0, 7, -1) }

        describe '#fundamental_frequency' do
          it 'has the fundamental frequency that we expect' do
            expect(scale.fundamental_frequency).to eq(594.0)
          end
        end

        describe '#size' do
          it 'has the size we expect' do
            expect(scale.size).to eq(7)
          end
        end

        describe '#notes' do
          it 'is an Array' do
            expect(scale.notes).to be_a(Array)
          end

          it 'has the expected size' do
            expect(scale.notes.size).to eq(7)
          end
        end

        describe '#tones' do
          it 'is an Array' do
            expect(scale.tones).to be_a(Array)
          end

          it 'has the expected size' do
            expect(scale.tones.size).to eq(7)
          end
        end

        describe '#offset' do
          it 'has the offset we expect' do
            expect(scale.offset).to eq(-1)
          end
        end

        # Don't run this test on travis since
        # we don't have permissions.
        unless(ENV['TRAVIS'].eql? "true")
          describe '#play' do
            it 'does not raises an error' do
              expect{ scale.play(1, 50) }.not_to raise_error
            end
          end
        end

        describe '#to_s' do
          it 'does not raises an error' do
            expect{ scale.to_s }.not_to raise_error
          end

          # it 'displays the expected tones' do
          #   expect(scale.to_s).to eql(expected_display_tones)
          # end
        end
      end
    end
  end
end