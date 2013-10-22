require 'spec_helper'
module Ceely
  module Harmonic
    describe Ceely::Harmonic::Scale do
      context "when it's a 33 note scale," do
        subject(:scale) { Ceely::Harmonic::Scale.new(528.0, 33) }

        describe '#fundamental_frequency' do
          it 'has the fundamental frequency that we expect' do
            expect(scale.fundamental_frequency).to eq(528.0)
          end
        end

        describe '#size' do
          it 'has the size we expect' do
            expect(scale.size).to eq(33)
          end
        end

        describe '#notes' do
          it 'is an Array' do
            expect(scale.notes).to be_a(Array)
          end

          it 'has the expected size' do
            expect(scale.notes.size).to eq(33)
          end
        end

        describe '#sort' do
          it 'is an Array' do
            expect(scale.sort).to be_a(Array)
          end

          it 'has the scale\'s size' do
            expect(scale.sort.size).to eq(33)
          end

          it 'has the given size' do
            expect(scale.sort(3).size).to eq(3)
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
