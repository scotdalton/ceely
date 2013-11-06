require 'spec_helper'
module Ceely
  describe Tone do
    context 'when a valid frequency is given,' do
      subject(:tone) { Tone.new(440, 0.5) }

      describe '#frequency' do
        it 'has the frequency that we expect' do
          expect(tone.frequency).to eq(440)
        end
      end

      describe '#duration' do
        it 'has the duration that we expect' do
          expect(tone.duration).to eq(0.5)
        end
      end

      describe '#player' do
        it 'has a player,' do
          expect(tone.player).to be_a(Player)
        end
      end

      describe '#==' do
        it 'compares frequencies,' do
          expect(tone == Tone.new(441, 0.5)).to be_false
          expect(tone == Tone.new(440, 0.5)).to be_true
          expect(tone == Tone.new(439, 0.5)).to be_false
        end
      end

      describe '#eql?' do
        it 'compares frequencies,' do
          expect(tone.eql? Tone.new(441, 0.5)).to be_false
          expect(tone.eql? Tone.new(440, 0.5)).to be_true
          expect(tone.eql? Tone.new(439, 0.5)).to be_false
        end
      end

      describe '#<=>' do
        it 'compares frequencies,' do
          expect(tone <=> Tone.new(441, 0.5)).to eq(-1)
          expect(tone <=> Tone.new(440, 0.5)).to eq(0)
          expect(tone <=> Tone.new(439, 0.5)).to eq(1)
        end
      end

      # Don't run this test on travis since
      # we don't have permissions.
      unless(ENV['TRAVIS'].eql? "true")
        describe '#play' do
          it 'plays' do
            expect { tone.play(50) }.not_to raise_error
          end
        end
      end
    end

    context "when a non number frequency is given" do
      describe '.new' do
        it 'raises an error' do
          expect{ Tone.new("Invalid frequency", 0.5) }.to raise_error(ArgumentError)
        end
      end
    end

    context "when a negative number frequency is given" do
      describe '.new' do
        it 'raises an error' do
          expect{ Tone.new(-100, 0.5) }.to raise_error(ArgumentError)
        end
      end
    end
  end
end
