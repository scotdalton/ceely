require 'spec_helper'
module Ceely
  include_package 'javax.sound.sampled'
  describe Player do
    context 'when the defaults are used,' do
      subject(:player) { Player.new }
      subject(:tone) { Tone.new(800, 0.5) }
      subject(:noise) { Noise.new("bass", 0.5) }
      subject(:tones) { [Tone.new(528, 1), Tone.new(594, 1), Tone.new(792, 1)] }
      subject(:amplitude) { 50 }
      subject(:amplitudes) { [50, 40] }

      describe '#sine_wave' do
        it 'does not error on the sine wave' do
          expect{ player.sine_wave(tone, amplitude) }.not_to raise_error
        end
      end

      describe '#format' do
        it 'has a format,' do
          expect(player.format).to be_a(AudioFormat)
        end
      end

      describe '#clip' do
        it 'has a clip,' do
          expect(player.clip).to be_a(Clip)
        end
      end

      describe '#mixer' do
        it 'has a mixer,' do
          expect(player.mixer).to be_a(Mixer)
        end
      end

      describe '#mixer_info' do
        it 'has a mixer_info,' do
          expect(player.mixer_info).to be_a(Mixer::Info)
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
        describe '#play_tone' do
          it 'plays the tone seconds' do
            expect { player.play_tone(tone, amplitude) }.not_to raise_error
          end
        end

        describe '#play_noise' do
          it 'plays the noise' do
            expect { player.play_noise(noise, amplitude) }.not_to raise_error
          end
        end

        describe '#play_tones' do
          it 'plays the tones' do
            expect { player.play_tones(tones, amplitude) }.not_to raise_error
          end

          it 'plays the tones at different amplitudes' do
            expect { player.play_tones(tones, *amplitudes) }.not_to raise_error
          end
        end
      end
    end
  end
end
