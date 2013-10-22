require 'spec_helper'
module Ceely
  describe Ceely::Chord do
    context "when it's the default chord," do
      subject(:chord) { Ceely::Chord.new }

      describe '#notes' do
        it 'is empty' do
          expect(chord.notes).to be_empty
        end
      end
    end

    context "when it's the default chord," do
      subject(:u) { Ceely::Pythagorean::Note.new(528.0) }
      subject(:m3) { Ceely::Pythagorean::Note.new(668.25) }
      subject(:p5) { Ceely::Pythagorean::Note.new(792.00) }
      subject(:chord) { Ceely::Chord.new(u, m3, p5) }

      describe '#notes' do
        it 'isn\'t empty' do
          expect(chord.notes).not_to be_empty
        end

        it 'has 3 elements' do
          expect(chord.notes.size).to eq(3)
        end
      end

      # Don't run this test on travis since
      # we don't have permissions.
      unless(ENV['TRAVIS'].eql? "true")
        describe '#play' do
          it 'plays for 2 seconds' do
            expect { chord.play(2, 50) }.not_to raise_error
          end
        end
      end
    end
  end
end
