require 'spec_helper'
module Ceely
  describe Noise do
    %w{ bass block conga cymbal snare tomtom triangle }.each do |file|
      context "when the #{file} file is given," do
        subject(:noise) { Noise.new(file, 0.5) }

        describe '#duration' do
          it 'has the duration that we expect' do
            expect(noise.duration).to eq(0.5)
          end
        end

        describe '#player' do
          it 'has a player,' do
            expect(noise.player).to be_a(Player)
          end
        end

        # Don't run this test on travis since
        # we don't have permissions.
        unless(ENV['TRAVIS'].eql? "true")
          describe '#play' do
            it 'plays' do
              expect { noise.play(50) }.not_to raise_error
            end
          end
        end
      end
    end

    context 'when an invalid file is given,' do
      describe '.new' do
        it 'raises a NotImplementedError' do
          expect { Noise.new("invalid", 0.5) }.to raise_error(NotImplementedError)
        end
      end
    end
  end
end
