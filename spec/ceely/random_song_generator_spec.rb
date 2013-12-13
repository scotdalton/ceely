require 'spec_helper'
module Ceely
  describe Ceely::RandomSongGenerator do
    context "when it's a random 3 note Pythagorean song," do
      subject(:scale) { Ceely::Scales::Pythagorean::Scale.new }
      subject(:song_generator) { Ceely::RandomSongGenerator.new(scale, 1, 3) }

      describe "#size" do
        it "should be 3" do
          expect(song_generator.size).to eq(3)
        end
      end

      describe "#song" do
        it "should be a Ceely::Song" do
          expect(song_generator.song).to be_a(Ceely::Song)
        end

        it "should have tempo 1" do
          expect(song_generator.song.tempo).to eq(1)
        end

        it "should have 3 notes" do
          expect(song_generator.song.playables.size).to eq(3)
        end

        # Don't run this test on travis since
        # we don't have permissions.
        unless(ENV['TRAVIS'].eql? "true")
          it 'should play' do
            expect { song_generator.song.play(50) }.not_to raise_error
          end
        end
      end
    end
  end
end
