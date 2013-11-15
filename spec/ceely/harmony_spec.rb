require 'spec_helper'
module Ceely
  describe Ceely::Harmony do
    context "when it's the default harmony," do
      subject(:harmony) { Ceely::Harmony.new(1) }

      describe '#notes' do
        it 'is empty' do
          expect(harmony.notes).to be_empty
        end
      end
    end

    context "when it's built from a Pythagorean scale," do
      scale = Ceely::Scales::Pythagorean::Scale.new
      subject(:c) { scale.note_by_name("C") }
      subject(:f) { scale.note_by_name("F") }
      subject(:g) { scale.note_by_name("G") }
      subject(:harmony) { Ceely::Harmony.new(1, c, f, g) }

      describe '#notes' do
        it 'isn\'t empty' do
          expect(harmony.notes).not_to be_empty
        end

        it 'has 3 elements' do
          expect(harmony.notes.size).to eq(3)
        end
      end

      # Don't run this test on travis since
      # we don't have permissions.
      unless(ENV['TRAVIS'].eql? "true")
        describe '#play' do
          it 'plays for 1 seconds' do
            expect { harmony.play(50, 40) }.not_to raise_error
          end
        end
      end
    end

    context "when it's built from an Even Tempered scale," do
      scale = Ceely::Scales::EvenTempered::Scale.new
      subject(:c) { scale.note_by_name("C") }
      subject(:f) { scale.note_by_name("F") }
      subject(:g) { scale.note_by_name("G") }
      subject(:harmony) { Ceely::Harmony.new(1, c, f, g) }

      describe '#notes' do
        it 'isn\'t empty' do
          expect(harmony.notes).not_to be_empty
        end

        it 'has 3 elements' do
          expect(harmony.notes.size).to eq(3)
        end
      end

      # Don't run this test on travis since
      # we don't have permissions.
      unless(ENV['TRAVIS'].eql? "true")
        describe '#play' do
          it 'plays for 1 seconds' do
            expect { harmony.play(50, 40) }.not_to raise_error
          end
        end
      end
    end

    context "when it's built from a Dodecaphonic scale," do
      subject(:scale) { Ceely::Scales::Dodecaphonic::Scale.new }
      subject(:c) { scale.note_by_name("C") }
      subject(:f) { scale.note_by_name("F") }
      subject(:g) { scale.note_by_name("G") }
      subject(:harmony) { Ceely::Harmony.new(1, c, f, g) }

      describe '#notes' do
        it 'isn\'t empty' do
          expect(harmony.notes).not_to be_empty
        end

        it 'has 3 elements' do
          expect(harmony.notes.size).to eq(3)
        end
      end

      # Don't run this test on travis since
      # we don't have permissions.
      unless(ENV['TRAVIS'].eql? "true")
        describe '#play' do
          it 'plays for 1 seconds' do
            expect { harmony.play(50, 40) }.not_to raise_error
          end
        end
      end
    end
  end
end
