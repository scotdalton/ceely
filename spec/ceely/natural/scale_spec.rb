require 'spec_helper'
module Ceely
  module Natural
    describe Ceely::Natural::Scale do
      natural["modes"].each do |mode, octaves|
        octaves.each do |octave_index, expected_frequencies|
          context "when we get the #{mode} mode" do
            subject(:scale) { Ceely::Natural::Scale.new }
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
        subject(:scale) { Ceely::Natural::Scale.new }

        describe '#fundamental_frequency' do
          it 'has the fundamental frequency that we expect' do
            expect(scale.fundamental_frequency).to eq(528.0)
          end
        end

        describe '#note_name' do
          it 'has the note name for the index' do
            expect(scale.note_name(-7)).to eq("C")
            expect(scale.note_name(-6)).to eq("D")
            expect(scale.note_name(-5)).to eq("E")
            expect(scale.note_name(-4)).to eq("F")
            expect(scale.note_name(-3)).to eq("G")
            expect(scale.note_name(-2)).to eq("A")
            expect(scale.note_name(-1)).to eq("B")
            expect(scale.note_name(0)).to eq("C")
            expect(scale.note_name(1)).to eq("D")
            expect(scale.note_name(2)).to eq("E")
            expect(scale.note_name(3)).to eq("F")
            expect(scale.note_name(4)).to eq("G")
            expect(scale.note_name(5)).to eq("A")
            expect(scale.note_name(6)).to eq("B")
            expect(scale.note_name(7)).to eq("C")
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

        describe '#note_names' do
          it 'is an Array' do
            expect(scale.note_names).to be_a(Array)
          end

          it 'isn\'t empty' do
            expect(scale.note_names).not_to be_empty
          end

          it 'has the expected note names' do
            expect(scale.note_names).to eq(%w{ C D E F G A B })
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
          it 'has 7 elements' do
            expect(scale.circle_of_fifths.size).to eq(7)
          end
        end

        # Don't run this test on travis since
        # we don't have permissions.
        unless(ENV['TRAVIS'].eql? "true")
          describe '#play' do
            it 'does not raises an error' do
              expect{ scale.play(1, 50) }.not_to raise_error
            end
          end

          describe '#play_mode' do
            it 'does not raises an error' do
              expect{ scale.play_mode("ionian", 0, 1, 50) }.not_to raise_error
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
        subject(:scale) { Ceely::Natural::Scale.new(594.0) }

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
              expect{ scale.play(1, 50) }.not_to raise_error
            end
          end

          describe '#play_mode' do
            it 'does not raises an error' do
              expect{ scale.play_mode("ionian", 0, 1, 50) }.not_to raise_error
            end
          end
        end

        describe '#to_s' do
          it 'does not raises an error' do
            expect{ scale.to_s }.not_to raise_error
          end
        end
      end

      context "when the natural pitches come from the scale," do
        scale = Ceely::Natural::Scale.new
        subject(:c) { scale.sort.find { |note| note.name.eql? "C" } }
        subject(:d) { scale.sort.find { |note| note.name.eql? "D" } }
        subject(:e) { scale.sort.find { |note| note.name.eql? "E" } }
        subject(:f) { scale.sort.find { |note| note.name.eql? "F" } }
        subject(:g) { scale.sort.find { |note| note.name.eql? "G" } }
        subject(:a) { scale.sort.find { |note| note.name.eql? "A" } }
        subject(:b) { scale.sort.find { |note| note.name.eql? "B" } }

        describe '#note_type C' do
          it 'has the type that we expect' do
            expect(c.type).to eq("1")
          end
        end

        describe '#note_type D' do
          it 'has the type that we expect' do
            expect(d.type).to eq("2")
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

        describe '#note_type G' do
          it 'has the type that we expect' do
            expect(g.type).to eq("5")
          end
        end

        describe '#note_type A' do
          it 'has the type that we expect' do
            expect(a.type).to eq("M6")
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

        describe '#interval from D to E' do
          it 'has the interval that we expect' do
            expect(d.interval(e)).to eq(Rational(9, 8))
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

        describe '#interval from G to A' do
          it 'has the interval that we expect' do
            expect(g.interval(a)).to eq(Rational(9, 8))
          end
        end

        describe '#interval from A to B' do
          it 'has the interval that we expect' do
            expect(a.interval(b)).to eq(Rational(9, 8))
          end
        end
      end
    end
  end
end
