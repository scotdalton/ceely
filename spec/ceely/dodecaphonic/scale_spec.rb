require 'spec_helper'
module Ceely
  module Dodecaphonic
    describe Ceely::Dodecaphonic::Scale do
      context 'when constructed with defaults,' do
        subject(:scale) { Ceely::Dodecaphonic::Scale.new }

        describe '#fundamental_frequency' do
          it 'has the fundamental frequency that we expect' do
            expect(scale.fundamental_frequency).to eq(528.0)
          end
        end

        describe '#note_name' do
          it 'has the note name for the index' do
            expect(scale.note_name(-13)).to eq("C")
            expect(scale.note_name(-12)).to eq("Db")
            expect(scale.note_name(-11)).to eq("D")
            expect(scale.note_name(-10)).to eq("Eb")
            expect(scale.note_name(-9)).to eq("E")
            expect(scale.note_name(-8)).to eq("F")
            expect(scale.note_name(-7)).to eq("Gb")
            expect(scale.note_name(-6)).to eq("F#")
            expect(scale.note_name(-5)).to eq("G")
            expect(scale.note_name(-4)).to eq("Ab")
            expect(scale.note_name(-3)).to eq("A")
            expect(scale.note_name(-2)).to eq("Bb")
            expect(scale.note_name(-1)).to eq("B")
            expect(scale.note_name(0)).to eq("C")
            expect(scale.note_name(1)).to eq("Db")
            expect(scale.note_name(2)).to eq("D")
            expect(scale.note_name(3)).to eq("Eb")
            expect(scale.note_name(4)).to eq("E")
            expect(scale.note_name(5)).to eq("F")
            expect(scale.note_name(6)).to eq("Gb")
            expect(scale.note_name(7)).to eq("F#")
            expect(scale.note_name(8)).to eq("G")
            expect(scale.note_name(9)).to eq("Ab")
            expect(scale.note_name(10)).to eq("A")
            expect(scale.note_name(11)).to eq("Bb")
            expect(scale.note_name(12)).to eq("B")
          end
        end

        describe '#size' do
          it 'has the size we expect' do
            expect(scale.size).to eq(13)
          end
        end

        describe '#offset' do
          it 'has the offset we expect' do
            expect(scale.offset).to eq(-6)
          end
        end

        describe '#notes' do
          it 'is an Array' do
            expect(scale.notes).to be_a(Array)
          end

          it 'has the expected size' do
            expect(scale.notes.size).to eq(13)
          end
        end

        describe '#sorted_notes' do
          it 'is an Array' do
            expect(scale.sorted_notes).to be_a(Array)
          end

          it 'has the expected size' do
            expect(scale.sorted_notes.size).to eq(13)
          end
        end

        describe '#sort' do
          it 'is an Array' do
            expect(scale.sort).to be_a(Array)
          end

          it 'has the scale\'s size' do
            expect(scale.sort.size).to eq(13)
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
            expect(scale.note_names).to eq(%w{ C Db D Eb E F Gb F# G Ab A Bb B })
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
            expect(scale.note_types).to eq(%w{ 1 m2 2 m3 M3 4 b5(b) b5(#) 5 m6 M6 m7 M7 })
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

          it 'has Gb seventh' do
            expect(scale.circle_of_fifths[6].name).to eq("Gb")
          end

          it 'has Db eighth' do
            expect(scale.circle_of_fifths[7].name).to eq("Db")
          end

          it 'has Ab ninth' do
            expect(scale.circle_of_fifths[8].name).to eq("Ab")
          end

          it 'has Eb tenth' do
            expect(scale.circle_of_fifths[9].name).to eq("Eb")
          end

          it 'has Bb eleventh' do
            expect(scale.circle_of_fifths[10].name).to eq("Bb")
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
              expect{ scale.play(50) }.not_to raise_error
            end
          end

          describe '#play_circle_of_fifths' do
            it 'does not raises an error' do
              expect{ scale.play_circle_of_fifths(50) }.not_to raise_error
            end
          end

          describe '#play_circle_of_fifths_in_octave 1' do
            it 'does not raises an error' do
              expect{ scale.play_circle_of_fifths_in_octave(1, 50) }.not_to raise_error
            end
          end
        end

        describe '#to_s' do
          it 'does not raises an error' do
            expect{ scale.to_s }.not_to raise_error
          end
        end
      end

      context "when it's the dodecaphonic pitches from the scale," do
        scale = Ceely::Dodecaphonic::Scale.new
        subject(:c) { scale.note_by_name("C") }
        subject(:d_flat) { scale.note_by_name("Db") }
        subject(:d) { scale.note_by_name("D") }
        subject(:e_flat) { scale.note_by_name("Eb") }
        subject(:e) { scale.note_by_name("E") }
        subject(:f) { scale.note_by_name("F") }
        subject(:g_flat) { scale.note_by_name("Gb") }
        subject(:f_sharp) { scale.note_by_name("F#") }
        subject(:g) { scale.note_by_name("G") }
        subject(:a_flat) { scale.note_by_name("Ab") }
        subject(:a) { scale.note_by_name("A") }
        subject(:b_flat) { scale.note_by_name("Bb") }
        subject(:b) { scale.note_by_name("B") }


        describe '#note_type C' do
          it 'has the type that we expect' do
            expect(c.type).to eq("1")
          end
        end

        describe '#note_type Db' do
          it 'has the type that we expect' do
            expect(d_flat.type).to eq("m2")
          end
        end

        describe '#note_type D' do
          it 'has the type that we expect' do
            expect(d.type).to eq("2")
          end
        end

        describe '#note_type Eb' do
          it 'has the type that we expect' do
            expect(e_flat.type).to eq("m3")
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

        describe '#note_type Gb' do
          it 'has the type that we expect' do
            expect(g_flat.type).to eq("b5(b)")
          end
        end

        describe '#note_type F#' do
          it 'has the type that we expect' do
            expect(f_sharp.type).to eq("b5(#)")
          end
        end

        describe '#note_type G' do
          it 'has the type that we expect' do
            expect(g.type).to eq("5")
          end
        end

        describe '#note_type Ab' do
          it 'has the type that we expect' do
            expect(a_flat.type).to eq("m6")
          end
        end

        describe '#note_type A' do
          it 'has the type that we expect' do
            expect(a.type).to eq("M6")
          end
        end

        describe '#note_type Bb' do
          it 'has the type that we expect' do
            expect(b_flat.type).to eq("m7")
          end
        end

        describe '#note_type B' do
          it 'has the type that we expect' do
            expect(b.type).to eq("M7")
          end
        end

        describe '#interval from c to d' do
          it 'has the interval that we expect' do
            expect(c.interval(d)).to eq(Rational(9, 8))
          end
        end

        describe '#interval from c to d_flat' do
          it 'has the interval that we expect' do
            expect(c.interval(d_flat)).to eq(Rational(256, 243))
          end
        end

        describe '#interval from d flat to d' do
          it 'has the interval that we expect' do
            expect(d_flat.interval(d)).to eq(Rational(2187, 2048))
          end
        end

        describe '#interval from d to e' do
          it 'has the interval that we expect' do
            expect(d.interval(e)).to eq(Rational(9, 8))
          end
        end

        describe '#interval from d to e flat' do
          it 'has the interval that we expect' do
            expect(d.interval(e_flat)).to eq(Rational(256, 243))
          end
        end

        describe '#interval from e flat to e' do
          it 'has the interval that we expect' do
            expect(e_flat.interval(e)).to eq(Rational(2187, 2048))
          end
        end

        describe '#interval from e to f' do
          it 'has the interval that we expect' do
            expect(e.interval(f)).to eq(Rational(256, 243))
          end
        end

        describe '#interval from f to g' do
          it 'has the interval that we expect' do
            expect(f.interval(g)).to eq(Rational(9, 8))
          end
        end

        describe '#interval from f to g flat' do
          it 'has the interval that we expect' do
            expect(f.interval(g_flat)).to eq(Rational(256, 243))
          end
        end

        describe '#interval from g flat to f sharp' do
          it 'has the interval that we expect' do
            expect(g_flat.interval(f_sharp)).to eq(Rational(531441, 524288))
          end

          it 'is the pythagorean comma' do
            expect(g_flat.interval_in_cents(f_sharp)).to be_within(0.01).of(23.46)
          end
        end

        describe '#interval from f sharp to g' do
          it 'has the interval that we expect' do
            expect(f_sharp.interval(g)).to eq(Rational(256, 243))
          end
        end

        describe '#interval from g to a' do
          it 'has the interval that we expect' do
            expect(g.interval(a)).to eq(Rational(9, 8))
          end
        end

        describe '#interval from g to a flat' do
          it 'has the interval that we expect' do
            expect(g.interval(a_flat)).to eq(Rational(256, 243))
          end
        end

        describe '#interval from a flat to a' do
          it 'has the interval that we expect' do
            expect(a_flat.interval(a)).to eq(Rational(2187, 2048))
          end
        end

        describe '#interval from a to b' do
          it 'has the interval that we expect' do
            expect(a.interval(b)).to eq(Rational(9, 8))
          end
        end

        describe '#interval from a to b flat' do
          it 'has the interval that we expect' do
            expect(a.interval(b_flat)).to eq(Rational(256, 243))
          end
        end

        describe '#interval from b flat to b' do
          it 'has the interval that we expect' do
            expect(b_flat.interval(b)).to eq(Rational(2187, 2048))
          end
        end
      end
    end
  end
end