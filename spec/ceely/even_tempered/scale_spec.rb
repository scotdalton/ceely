require 'spec_helper'
module Ceely
  module EvenTempered
    describe Ceely::EvenTempered::Scale do
      context "when it's a 12 note scale," do
        subject(:scale) { Ceely::EvenTempered::Scale.new(528.0) }

        describe '#fundamental_frequency' do
          it 'has the fundamental frequency that we expect' do
            expect(scale.fundamental_frequency).to eq(528.0)
          end
        end

        describe '#size' do
          it 'has the size we expect' do
            expect(scale.size).to eq(12)
          end
        end

        describe '#offset' do
          it 'has the offset we expect' do
            expect(scale.offset).to eq(0)
          end
        end

        describe '#notes' do
          it 'is an Array' do
            expect(scale.notes).to be_a(Array)
          end

          it 'has the expected size' do
            expect(scale.notes.size).to eq(12)
          end
        end

        describe '#sort' do
          it 'is an Array' do
            expect(scale.sort).to be_a(Array)
          end

          it 'has the scale\'s size' do
            expect(scale.sort.size).to eq(12)
          end

          it 'has the given size' do
            expect(scale.sort(3).size).to eq(3)
          end
        end

        describe '#note_names' do
          it 'is an Array' do
            expect(scale.note_names).to be_a(Array)
          end

          it 'isn\'t empty' do
            expect(scale.note_names).not_to be_empty
          end

          it 'has the expected note names' do
            expect(scale.note_names).to eq(%w{ C C# D D# E F F# G G# A A# B })
          end
        end

        describe '#note_types' do
          it 'is an Array' do
            expect(scale.note_types).to be_a(Array)
          end

          it 'isn\'t empty' do
            expect(scale.note_types).not_to be_empty
          end

          it 'has the expected note types' do
            expect(scale.note_types).to eq(%w{ 1 m2 2 m3 M3 4 b5 5 m6 M6 m7 M7 })
          end
        end

        describe '#circle_of_fifths' do
          it 'has 12 elements' do
            expect(scale.circle_of_fifths.size).to eq(12)
          end

          it 'has C first' do
            expect(scale.circle_of_fifths.first.name).to eq("C")
          end

          it 'has G second' do
            expect(scale.circle_of_fifths[1].name).to eq("G")
          end

          it 'has D third' do
            expect(scale.circle_of_fifths[2].name).to eq("D")
          end

          it 'has A fourth' do
            expect(scale.circle_of_fifths[3].name).to eq("A")
          end

          it 'has E fifth' do
            expect(scale.circle_of_fifths[4].name).to eq("E")
          end

          it 'has B sixth' do
            expect(scale.circle_of_fifths[5].name).to eq("B")
          end

          it 'has F# seventh' do
            expect(scale.circle_of_fifths[6].name).to eq("F#")
          end

          it 'has C# eighth' do
            expect(scale.circle_of_fifths[7].name).to eq("C#")
          end

          it 'has G# ninth' do
            expect(scale.circle_of_fifths[8].name).to eq("G#")
          end

          it 'has D# tenth' do
            expect(scale.circle_of_fifths[9].name).to eq("D#")
          end

          it 'has A# eleventh' do
            expect(scale.circle_of_fifths[10].name).to eq("A#")
          end

          it 'has F twelfth' do
            expect(scale.circle_of_fifths[11].name).to eq("F")
          end
        end

        # Don't run this test on travis since
        # we don't have permissions.
        unless(ENV['TRAVIS'].eql? "true")
          describe '#play' do
            it 'does not raises an error' do
              expect{ scale.play(0.5, 50) }.not_to raise_error
            end
          end

          describe '#play_circle_of_fifths' do
            it 'does not raises an error' do
              expect{ scale.play_circle_of_fifths(0.5, 50) }.not_to raise_error
            end
          end

          describe '#play_circle_of_fifths_in_octave 1' do
            it 'does not raises an error' do
              expect{ scale.play_circle_of_fifths_in_octave(1, 0.5, 50) }.not_to raise_error
            end
          end
        end

        describe '#to_s' do
          it 'does not raises an error' do
            expect{ scale.to_s }.not_to raise_error
          end
        end
      end

      context "when the notes come from the scale," do
        scale = Ceely::EvenTempered::Scale.new
        subject(:c) { scale.note_by_name("C") }
        subject(:c_sharp) { scale.note_by_name("C#") }
        subject(:d) { scale.note_by_name("D") }
        subject(:d_sharp) { scale.note_by_name("D#") }
        subject(:e) { scale.note_by_name("E") }
        subject(:f) { scale.note_by_name("F") }
        subject(:f_sharp) { scale.note_by_name("F#") }
        subject(:g) { scale.note_by_name("G") }
        subject(:g_sharp) { scale.note_by_name("G#") }
        subject(:a) { scale.note_by_name("A") }
        subject(:a_sharp) { scale.note_by_name("A#") }
        subject(:b) { scale.note_by_name("B") }

        describe '#note_type C' do
          it 'has the type that we expect' do
            expect(c.type).to eq("1")
          end
        end

        describe '#note_type C#' do
          it 'has the type that we expect' do
            expect(c_sharp.type).to eq("m2")
          end
        end

        describe '#note_type D' do
          it 'has the type that we expect' do
            expect(d.type).to eq("2")
          end
        end

        describe '#note_type D#' do
          it 'has the type that we expect' do
            expect(d_sharp.type).to eq("m3")
          end
        end

        describe '#note_type E' do
          it 'has the type that we expect' do
            expect(e.type).to eq("M3")
          end
        end

        describe '#note_type F' do
          it 'has the type that we expect' do
            expect(f.type).to eq("4")
          end
        end

        describe '#note_type F#' do
          it 'has the type that we expect' do
            expect(f_sharp.type).to eq("b5")
          end
        end

        describe '#note_type G' do
          it 'has the type that we expect' do
            expect(g.type).to eq("5")
          end
        end

        describe '#note_type G#' do
          it 'has the type that we expect' do
            expect(g_sharp.type).to eq("m6")
          end
        end

        describe '#note_type A' do
          it 'has the type that we expect' do
            expect(a.type).to eq("M6")
          end
        end

        describe '#note_type A#' do
          it 'has the type that we expect' do
            expect(a_sharp.type).to eq("m7")
          end
        end

        describe '#note_type B' do
          it 'has the type that we expect' do
            expect(b.type).to eq("M7")
          end
        end

        describe '#interval from C to D' do
          it 'has the interval that we expect' do
            expect(c.interval_in_cents(d)).to be_within(0.01).of(200)
          end
        end

        describe '#interval from C to C#' do
          it 'has the interval that we expect' do
            expect(c.interval_in_cents(c_sharp)).to be_within(0.01).of(100)
          end
        end

        describe '#interval from C# to D' do
          it 'has the interval that we expect' do
            expect(c_sharp.interval_in_cents(d)).to be_within(0.01).of(100)
          end
        end

        describe '#interval from D to E' do
          it 'has the interval that we expect' do
            expect(d.interval_in_cents(e)).to be_within(0.01).of(200)
          end
        end

        describe '#interval from D to D#' do
          it 'has the interval that we expect' do
            expect(d.interval_in_cents(d_sharp)).to be_within(0.01).of(100)
          end
        end

        describe '#interval from D# to E' do
          it 'has the interval that we expect' do
            expect(d_sharp.interval_in_cents(e)).to be_within(0.01).of(100)
          end
        end

        describe '#interval from E to F' do
          it 'has the interval that we expect' do
            expect(e.interval_in_cents(f)).to be_within(0.01).of(100)
          end
        end

        describe '#interval from F to G' do
          it 'has the interval that we expect' do
            expect(f.interval_in_cents(g)).to be_within(0.01).of(200)
          end
        end

        describe '#interval from F to F#' do
          it 'has the interval that we expect' do
            expect(f.interval_in_cents(f_sharp)).to be_within(0.01).of(100)
          end
        end

        describe '#interval from F# to G' do
          it 'has the interval that we expect' do
            expect(f_sharp.interval_in_cents(g)).to be_within(0.01).of(100)
          end
        end

        describe '#interval from G to A' do
          it 'has the interval that we expect' do
            expect(g.interval_in_cents(a)).to be_within(0.01).of(200)
          end
        end

        describe '#interval from G to G#' do
          it 'has the interval that we expect' do
            expect(g.interval_in_cents(g_sharp)).to be_within(0.01).of(100)
          end
        end

        describe '#interval from G# to A' do
          it 'has the interval that we expect' do
            expect(g_sharp.interval_in_cents(a)).to be_within(0.01).of(100)
          end
        end

        describe '#interval from A to B' do
          it 'has the interval that we expect' do
            expect(a.interval_in_cents(b)).to be_within(0.01).of(200)
          end
        end

        describe '#interval from A to A#' do
          it 'has the interval that we expect' do
            expect(a.interval_in_cents(a_sharp)).to be_within(0.01).of(100)
          end
        end

        describe '#interval from A# to B' do
          it 'has the interval that we expect' do
            expect(a_sharp.interval_in_cents(b)).to be_within(0.01).of(100)
          end
        end
      end
    end
  end
end
