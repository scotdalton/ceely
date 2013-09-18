require 'spec_helper'
module Ceely
  include_package 'javax.sound.sampled'
  describe Player do
    context 'when the defaults are used,' do
      subject(:player) { Player.new }
      subject(:note) { Note::Base.new(800) }

      describe '#sine_wave' do
        it 'does not error on the sine wave' do
          expect{ player.sine_wave(note, 5, 50) }.not_to raise_error
        end
      end

      describe '#format' do
        it 'has a format,' do
          expect(player.format).to be_a(AudioFormat)
        end
      end

      describe '#line' do
        it 'has a line,' do
          expect(player.line).to be_a(SourceDataLine)
        end
      end

      describe '#encoding' do
        it 'has an encoding,' do
          expect(player.encoding).to be_a(AudioFormat::Encoding)
        end
      end

      # Don't run this test on travis since
      # we don't have permissions.
      unless(ENV['TRAVIS'].eql? "true")
        describe '#play' do
          it 'plays for 2 seconds' do
            expect { player.play(note, 2, 50) }.not_to raise_error
          end
        end
      end
    end
  end
end
