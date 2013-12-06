require 'spec_helper'
module Ceely
  module Scales
    module Rameau
      describe Ceely::Scales::Rameau::Scale do

        context 'when constructed with defaults,' do
          subject(:scale) { Ceely::Scales::Rameau::Scale.new }

          describe '#fundamental_frequency' do
            it 'has the fundamental frequency that we expect' do
              expect(scale.fundamental_frequency).to eq(528.0)
            end
          end

          describe '#size' do
            it 'has the size we expect' do
              expect(scale.size).to eq(7)
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

          describe '#note_types' do
            it 'is an Array' do
              expect(scale.note_types).to be_a(Array)
            end

            it 'isn\'t empty' do
              expect(scale.note_types).not_to be_empty
            end

            it 'has the expected note types' do
              expect(scale.note_types).to eq(%w{ 1 M2 M3 4 5 M6 M7 })
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

        context "when the notes come from the scale," do
          scale = Ceely::Scales::Rameau::Scale.new
          subject(:c) { scale.note_by_name("C") }
          subject(:d) { scale.note_by_name("D") }
          subject(:e) { scale.note_by_name("E") }
          subject(:f) { scale.note_by_name("F") }
          subject(:g) { scale.note_by_name("G") }
          subject(:a) { scale.note_by_name("A") }
          subject(:b) { scale.note_by_name("B") }
          subject(:c_in_octave_1) { scale.note_by_name("C").in_octave(1) }

          describe '#note_type C' do
            it 'has the type that we expect' do
              expect(c.type).to eq("1")
            end
          end

          describe '#note_type D' do
            it 'has the type that we expect' do
              expect(d.type).to eq("M2")
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
            it 'has the interval 9/8' do
              expect(c.interval(d)).to eq(Rational(9, 8))
            end
          end

          describe '#interval from D to E' do
            it 'has the interval 10/9' do
              expect(d.interval(e)).to eq(Rational(10, 9))
            end
          end

          describe '#interval from E to F' do
            it 'has the interval 16/15' do
              expect(e.interval(f)).to eq(Rational(16, 15))
            end
          end

          describe '#interval from F to G' do
            it 'has the interval 9/8' do
              expect(f.interval(g)).to eq(Rational(9, 8))
            end
          end

          describe '#interval from G to A' do
            it 'has the interval 10/9' do
              expect(g.interval(a)).to eq(Rational(10, 9))
            end
          end

          describe '#interval from A to B' do
            it 'has the interval 9/8' do
              expect(a.interval(b)).to eq(Rational(9, 8))
            end
          end

          describe '#interval from B to C in the next octave' do
            it 'has the interval 16/15' do
              expect(b.interval(c_in_octave_1)).to eq(Rational(16, 15))
            end
          end
        end

        rameau["sharp_keys"].each_with_index do |expected_values, index|
          expected_frequencies = expected_values["frequencies"]
          expected_names = expected_values["names"]
          context "when it's sharpened #{index + 1} times," do
            subject(:scale) do
              scale = Ceely::Scales::Rameau::Scale.new
              (index+1).times { scale = scale.sharpen }
              scale
            end

            describe "#sharpen" do
              it "has the expected frequencies" do
                frequencies = scale.sorted_notes.collect { |note| note.frequency }
                expect(frequencies).to eq(expected_frequencies)
              end
            end
            describe "#note_names" do
              it "has the expected names" do
                expect(scale.note_names).to eq(expected_names)
              end
            end
          end
        end

        rameau["flat_keys"].each_with_index do |expected_values, index|
          expected_frequencies = expected_values["frequencies"]
          expected_names = expected_values["names"]
          context "when it's flattened #{index + 1} times," do
            subject(:scale) do
              scale = Ceely::Scales::Rameau::Scale.new
              (index+1).times { scale = scale.flatten }
              scale
            end

            describe "#sharpen" do
              it "has the expected frequencies" do
                frequencies = scale.sorted_notes.collect { |note| note.frequency }
                frequencies.each_with_index do |frequency, index|
                  expect(frequency).to be_within(0.1).of(expected_frequencies[index])
                end
              end
            end
            describe "#note_names" do
              it "has the expected names" do
                expect(scale.note_names).to eq(expected_names)
              end
            end
          end
        end
      end
    end
  end
end
