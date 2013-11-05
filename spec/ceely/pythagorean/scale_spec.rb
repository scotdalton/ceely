require 'spec_helper'
module Ceely
  module Pythagorean
    describe Ceely::Pythagorean::Scale do
      pythagorean["modes"].each do |mode, octaves|
        octaves.each do |octave_index, expected_frequencies|
          context "when we get the #{mode} mode" do
            subject(:scale) { Ceely::Pythagorean::Scale.new }
            describe "##{mode} in octave #{octave_index}" do
              it 'has 8 elements' do
                expect(scale.send(mode.to_sym, octave_index).size).to be(8)
              end
              it 'has the frequencies that we expect' do
                frequencies = scale.send(mode.to_sym, octave_index).collect { |note| 
                  note.frequency 
                }
                expect(frequencies).to eq(expected_frequencies)
              end
            end
          end
        end
      end

      context 'when constructed with defaults,' do
        subject(:scale) { Ceely::Pythagorean::Scale.new }

        describe '#fundamental_frequency' do
          it 'has the fundamental frequency that we expect' do
            expect(scale.fundamental_frequency).to eq(528.0)
          end
        end

        describe '#note_name' do
          it 'has the note name for the index' do
            expect(scale.note_name(-13)).to eq("C")
            expect(scale.note_name(-12)).to eq("C#")
            expect(scale.note_name(-11)).to eq("D")
            expect(scale.note_name(-10)).to eq("D#")
            expect(scale.note_name(-9)).to eq("E")
            expect(scale.note_name(-8)).to eq("F")
            expect(scale.note_name(-7)).to eq("Gb")
            expect(scale.note_name(-6)).to eq("F#")
            expect(scale.note_name(-5)).to eq("G")
            expect(scale.note_name(-4)).to eq("G#")
            expect(scale.note_name(-3)).to eq("A")
            expect(scale.note_name(-2)).to eq("A#")
            expect(scale.note_name(-1)).to eq("B")
            expect(scale.note_name(0)).to eq("C")
            expect(scale.note_name(1)).to eq("C#")
            expect(scale.note_name(2)).to eq("D")
            expect(scale.note_name(3)).to eq("D#")
            expect(scale.note_name(4)).to eq("E")
            expect(scale.note_name(5)).to eq("F")
            expect(scale.note_name(6)).to eq("Gb")
            expect(scale.note_name(7)).to eq("F#")
            expect(scale.note_name(8)).to eq("G")
            expect(scale.note_name(9)).to eq("G#")
            expect(scale.note_name(10)).to eq("A")
            expect(scale.note_name(11)).to eq("A#")
            expect(scale.note_name(12)).to eq("B")
          end
        end

        describe '#note_type' do
          it 'has the note type for the index' do
            expect(scale.note_type(-13)).to eq("1")
            expect(scale.note_type(-12)).to eq("m2")
            expect(scale.note_type(-11)).to eq("2")
            expect(scale.note_type(-10)).to eq("m3")
            expect(scale.note_type(-9)).to eq("M3")
            expect(scale.note_type(-8)).to eq("4")
            expect(scale.note_type(-7)).to eq("b5(b)")
            expect(scale.note_type(-6)).to eq("b5(#)")
            expect(scale.note_type(-5)).to eq("5")
            expect(scale.note_type(-4)).to eq("m6")
            expect(scale.note_type(-3)).to eq("M6")
            expect(scale.note_type(-2)).to eq("m7")
            expect(scale.note_type(-1)).to eq("M7")
            expect(scale.note_type(0)).to eq("1")
            expect(scale.note_type(1)).to eq("m2")
            expect(scale.note_type(2)).to eq("2")
            expect(scale.note_type(3)).to eq("m3")
            expect(scale.note_type(4)).to eq("M3")
            expect(scale.note_type(5)).to eq("4")
            expect(scale.note_type(6)).to eq("b5(b)")
            expect(scale.note_type(7)).to eq("b5(#)")
            expect(scale.note_type(8)).to eq("5")
            expect(scale.note_type(9)).to eq("m6")
            expect(scale.note_type(10)).to eq("M6")
            expect(scale.note_type(11)).to eq("m7")
            expect(scale.note_type(12)).to eq("M7")
          end
        end

        describe '#size' do
          it 'has the size we expect' do
            expect(scale.size).to eq(13)
          end
        end

        describe '#offset' do
          it 'has the offset we expect' do
            expect(scale.offset).to eq(-1)
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
            expect(scale.note_names).to eq(%w{ C C# D D# E F Gb F# G G# A A# B })
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

        describe '#first_mode' do
          it 'is an Array' do
            expect(scale.first_mode).to be_a(Array)
          end

          it 'has the expected size' do
            expect(scale.first_mode.size).to eq(7)
          end
        end

        describe '#nth_mode' do
          it 'is an Array' do
            expect(scale.nth_mode(0)).to be_a(Array)
          end

          it 'has the expected size' do
            expect(scale.nth_mode(0).size).to eq(8)
          end

          it 'has the expected first name' do
            expect(scale.nth_mode(0).first.name).to eq("C")
          end

          it 'is an Array' do
            expect(scale.nth_mode(1)).to be_a(Array)
          end

          it 'has the expected size' do
            expect(scale.nth_mode(1).size).to eq(8)
          end

          it 'has the expected first name' do
            expect(scale.nth_mode(1).first.name).to eq("D")
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
              expect{ scale.play(50) }.not_to raise_error
            end
          end

          describe '#play_mode' do
            it 'does not raises an error' do
              expect{ scale.play_mode("ionian", 0, 50) }.not_to raise_error
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

      context 'when constructed with inputs,' do
        subject(:scale) { Ceely::Pythagorean::Scale.new(594.0, 7, -1, [], []) }

        describe '#fundamental_frequency' do
          it 'has the fundamental frequency that we expect' do
            expect(scale.fundamental_frequency).to eq(594.0)
          end
        end

        describe '#size' do
          it 'has the size we expect' do
            expect(scale.size).to eq(7)
          end
        end

        describe '#offset' do
          it 'has the offset we expect' do
            expect(scale.offset).to eq(-1)
          end
        end

        describe '#notes' do
          it 'is an Array' do
            expect(scale.notes).to be_a(Array)
          end

          it 'has the expected size' do
            expect(scale.notes.size).to eq(7)
          end
        end

        describe '#sorted_notes' do
          it 'is an Array' do
            expect(scale.sorted_notes).to be_a(Array)
          end

          it 'has the expected size' do
            expect(scale.sorted_notes.size).to eq(7)
          end
        end

        describe '#sort' do
          it 'is an Array' do
            expect(scale.sort).to be_a(Array)
          end

          it 'has the scale\'s size' do
            expect(scale.sort.size).to eq(7)
          end

          it 'has the given size' do
            expect(scale.sort(3).size).to eq(3)
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
        end

        describe '#to_s' do
          it 'does not raises an error' do
            expect{ scale.to_s }.not_to raise_error
          end
        end
      end

      context "when the pythagorean natural and chromatic pitches come from the scale," do
        scale = Ceely::Pythagorean::Scale.new
        subject(:c) { scale.note_by_name("C") }
        subject(:c_sharp) { scale.note_by_name("C#") }
        subject(:d) { scale.note_by_name("D") }
        subject(:d_sharp) { scale.note_by_name("D#") }
        subject(:e) { scale.note_by_name("E") }
        subject(:f) { scale.note_by_name("F") }
        subject(:g_flat) { scale.note_by_name("Gb") }
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
            expect(c.interval(d)).to eq(Rational(9, 8))
          end
        end

        describe '#interval from C to C#' do
          it 'has the interval that we expect' do
            expect(c.interval(c_sharp)).to eq(Rational(2187, 2048))
          end
        end

        describe '#interval from C# to D' do
          it 'has the interval that we expect' do
            expect(c_sharp.interval(d)).to eq(Rational(256, 243))
          end
        end

        describe '#interval from D to E' do
          it 'has the interval that we expect' do
            expect(d.interval(e)).to eq(Rational(9, 8))
          end
        end

        describe '#interval from D to D#' do
          it 'has the interval that we expect' do
            expect(d.interval(d_sharp)).to eq(Rational(2187, 2048))
          end
        end

        describe '#interval from D# to E' do
          it 'has the interval that we expect' do
            expect(d_sharp.interval(e)).to eq(Rational(256, 243))
          end
        end

        describe '#interval from E to F' do
          it 'has the interval that we expect' do
            expect(e.interval(f)).to eq(Rational(256, 243))
          end
        end

        describe '#interval from F to G' do
          it 'has the interval that we expect' do
            expect(f.interval(g)).to eq(Rational(9, 8))
          end
        end

        describe '#interval from F to Gb' do
          it 'has the interval that we expect' do
            expect(f.interval(g_flat)).to eq(Rational(531441, 524288))
          end
        end

        describe '#interval from Gb to F#' do
          it 'has the interval that we expect' do
            expect(g_flat.interval(f_sharp)).to eq(Rational(256, 243))
          end
        end

        describe '#interval from F# to G' do
          it 'has the interval that we expect' do
            expect(f_sharp.interval(g)).to eq(Rational(256, 243))
          end
        end

        describe '#interval from G to A' do
          it 'has the interval that we expect' do
            expect(g.interval(a)).to eq(Rational(9, 8))
          end
        end

        describe '#interval from G to G#' do
          it 'has the interval that we expect' do
            expect(g.interval(g_sharp)).to eq(Rational(2187, 2048))
          end
        end

        describe '#interval from G# to A' do
          it 'has the interval that we expect' do
            expect(g_sharp.interval(a)).to eq(Rational(256, 243))
          end
        end

        describe '#interval from A to B' do
          it 'has the interval that we expect' do
            expect(a.interval(b)).to eq(Rational(9, 8))
          end
        end

        describe '#interval from A to A#' do
          it 'has the interval that we expect' do
            expect(a.interval(a_sharp)).to eq(Rational(2187, 2048))
          end
        end

        describe '#interval from A# to B' do
          it 'has the interval that we expect' do
            expect(a_sharp.interval(b)).to eq(Rational(256, 243))
          end
        end
      end
    end
  end
end