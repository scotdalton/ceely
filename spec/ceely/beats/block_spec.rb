require 'spec_helper'
module Ceely
  module Beats
    describe Ceely::Beats::Block do
      subject(:beat) { Ceely::Beats::Block.new(0.5) }

      describe '#duration' do
        it 'has the duration we expect' do
          expect(beat.duration).to eq(0.5)
        end
      end

      describe '#noise' do
        it 'doesn\'t raise a NotImplementedError' do
          expect{ beat.noise }.not_to raise_error
        end

        it 'is a Noise' do
          expect(beat.noise).to be_a(Noise)
        end
      end

      # Don't run this test on travis since
      # we don't have permissions.
      unless(ENV['TRAVIS'].eql? "true")
        describe '#play' do
          it 'plays' do
            expect { beat.play(50) }.not_to raise_error
          end
        end
      end
    end
  end
end
