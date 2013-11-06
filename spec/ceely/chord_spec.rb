require 'spec_helper'
module Ceely
  describe Ceely::Chord do
    context "when it's the default chord," do
      subject(:chord) { Ceely::Chord.new(2) }

      describe '#notes' do
        it 'is empty' do
          expect(chord.notes).to be_empty
        end
      end
    end

    context "when it's built from a Pythagorean scale," do
      scale = Ceely::Scales::Pythagorean::Scale.new
      subject(:u) { scale.note_by_type("1") }
      subject(:m3) { scale.note_by_type("M3") }
      subject(:p5) { scale.note_by_type("5") }
      subject(:chord) { Ceely::Chord.new(2, u, m3, p5) }

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
            expect { chord.play(50) }.not_to raise_error
          end
        end
      end
    end

    context "when it's built from an Even Tempered scale," do
      scale = Ceely::Scales::EvenTempered::Scale.new
      subject(:u) { scale.note_by_type("1") }
      subject(:m3) { scale.note_by_type("M3") }
      subject(:p5) { scale.note_by_type("5") }
      subject(:chord) { Ceely::Chord.new(2, u, m3, p5) }

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
            expect { chord.play(50) }.not_to raise_error
          end
        end
      end
    end

    context "when it's built from a Dodecaphonic scale," do
      subject(:scale) { Ceely::Scales::Dodecaphonic::Scale.new }
      subject(:u) { scale.note_by_type("1") }
      subject(:m3) { scale.note_by_type("M3") }
      subject(:p5) { scale.note_by_type("5") }
      subject(:chord) { Ceely::Chord.new(2, u, m3, p5) }

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
            expect { chord.play(50) }.not_to raise_error
          end
        end
      end
    end
  end
end
