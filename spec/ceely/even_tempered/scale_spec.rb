require 'spec_helper'
module Ceely
  module EvenTempered
    describe Ceely::EvenTempered::Scale do
      context "when it's a 12 note scale," do
        subject(:scale) { Ceely::EvenTempered::Scale.new(528.0) }

        describe '#fundamental_frequency' do
          it 'has the fundamental frequency that we expect' do
            expect(scale.fundamental_frequency).to eq(528.0)
          end
        end

        describe '#size' do
          it 'has the size we expect' do
            expect(scale.size).to eq(12)
          end
        end

        describe '#mode_size' do
          it 'has the mode_size we expect' do
            expect(scale.mode_size).to eq(8)
          end
        end

        describe '#notes' do
          it 'is an Array' do
            expect(scale.notes).to be_a(Array)
          end

          it 'has the expected size' do
            expect(scale.notes.size).to eq(12)
          end
        end

        describe '#sort_notes' do
          it 'is an Array' do
            expect(scale.sort_notes).to be_a(Array)
          end

          it 'has the scale\'s size' do
            expect(scale.sort_notes.size).to eq(12)
          end

          it 'has the given size' do
            expect(scale.sort_notes(3).size).to eq(3)
          end
        end

        describe '#offset' do
          it 'has the offset we expect' do
            expect(scale.offset).to eq(0)
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
        end
      end
    end
  end
end
