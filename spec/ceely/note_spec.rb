require 'spec_helper'
module Ceely
  describe Ceely::Note do
    context "when we have generic notes" do
      subject(:note) { Ceely::Note.new(528.0, nil, 2, 0, "A") }
      subject(:other_note) { Ceely::Note.new(528.0, nil, 2, 1, "B") }

      describe '#raw_frequency' do
        it 'should raise a NotImplementedError' do
          expect{ note.raw_frequency }.to raise_error(NotImplementedError)
        end
      end

      describe '#index' do
        it 'should be 2' do
          expect(note.index).to eq(2)
        end
      end

      describe '#name' do
        it 'should be "A"' do
          expect(note.name).to eq("A")
        end
      end

      describe '#duration' do
        it 'should be 0.5' do
          expect(note.duration).to eq(0.5)
        end
      end

      describe '#factor' do
        it 'should raise a NotImplementedError' do
          expect{ note.factor }.to raise_error(NotImplementedError)
        end
      end

      describe '#raw_octave' do
        it 'should raise a NotImplementedError' do
          expect{ expect(note.raw_octave) }.to raise_error(NotImplementedError)
        end
      end

      describe '#octave_adjusted_denominator' do
        it 'should raise a NotImplementedError' do
          expect{ note.octave_adjusted_denominator }.to raise_error(NotImplementedError)
        end
      end

      describe '#octave_adjusted_factor' do
        it 'should raise a NotImplementedError' do
          expect{ note.octave_adjusted_factor }.to raise_error(NotImplementedError)
        end
      end

      describe '#frequency' do
        it 'should raise a NotImplementedError' do
          expect{ note.frequency }.to raise_error(NotImplementedError)
        end
      end

      describe '#tone' do
        it 'should raise a NotImplementedError' do
          expect{ note.tone }.to raise_error(NotImplementedError)
        end
      end

      describe '#play' do
        it 'should raise a NotImplementedError' do
          expect{ note.play(50) }.to raise_error(NotImplementedError)
        end
      end

      describe '#cents' do
        it 'should raise a NotImplementedError' do
          expect{ note.cents }.to raise_error(NotImplementedError)
        end
      end

      describe '#interval_in_cents' do
        it 'should raise a NotImplementedError' do
          expect{ note.interval_in_cents(other_note) }.to raise_error(NotImplementedError)
        end
      end

      describe '#interval' do
        it 'should raise a NotImplementedError' do
          expect{ note.interval(other_note) }.to raise_error(NotImplementedError)
        end
      end

      describe '#<=>' do
        it 'should raise a NotImplementedError' do
          expect{ note <=> other_note }.to raise_error(NotImplementedError)
        end
      end

      describe '#==' do
        it 'should raise a NotImplementedError' do
          expect{ note == other_note }.to raise_error(NotImplementedError)
        end
      end

      describe '#eql?' do
        it 'should raise a NotImplementedError' do
          expect{ note.eql?(other_note) }.to raise_error(NotImplementedError)
        end
      end

      describe '#interval' do
        it 'should raise a NotImplementedError' do
          expect{ note.interval(other_note) }.to raise_error(NotImplementedError)
        end
      end

      describe '#to_s' do
        it 'should raise a NotImplementedError' do
          expect{ note.to_s }.to raise_error(NotImplementedError)
        end
      end
    end

    context "when comparing specific note implementations" do
      subject(:pythagrean_scale) { Ceely::Scales::Pythagorean::Scale.new(528.0) }
      subject(:pythagorean_c) { pythagrean_scale.note_by_name("C") }
      subject(:pythagorean_d) { pythagrean_scale.note_by_name("D") }
      subject(:harmonic_scale) { Ceely::Scales::Harmonic::Scale.new(528.0) }
      subject(:harmonic_c) { harmonic_scale.note_by_name("C") }
      subject(:harmonic_d) { harmonic_scale.note_by_name("D") }

      describe Ceely::Scales::Pythagorean::Note do
        describe '#==' do
          it "should be true when given itself" do
            expect(pythagorean_c == pythagorean_c).to be(true)
          end

          it "should be false when given a different Pythagorean::Note" do
            expect(pythagorean_c == pythagorean_d).to be(false)
          end

          it "should be true when given a Harmonic::Note with the same frequency and duration" do
            expect(pythagorean_c == harmonic_c).to be(true)
          end

          it "should be false when given a Harmonic::Note with a different frequency and duration" do
            expect(pythagorean_c == harmonic_d).to be(false)
          end
        end

        describe '#eql?' do
          it "should be true when given itself" do
            expect(pythagorean_c.eql?(pythagorean_c)).to be(true)
          end

          it "should be false when given a different Pythagorean::Note" do
            expect(pythagorean_c.eql?(pythagorean_d)).to be(false)
          end

          it "should be false when given a Harmonic::Note with the same frequency and duration" do
            expect(pythagorean_c.eql?(harmonic_c)).to be(false)
          end

          it "should be false when given a Harmonic::Note with a different frequency and duration" do
            expect(pythagorean_c.eql?(harmonic_d)).to be(false)
          end
        end
      end
    end
  end
end
