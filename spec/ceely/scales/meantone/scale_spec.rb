require 'spec_helper'
module Ceely
  module Scales
    module Meantone
      describe Ceely::Scales::Meantone::Scale do
        context 'when constructed with defaults,' do
          subject(:scale) { Ceely::Scales::Meantone::Scale.new }

          describe '#fundamental_frequency' do
            it 'has the fundamental frequency that we expect' do
              expect(scale.fundamental_frequency).to eq(528.0)
            end
          end

          describe '#note_name' do
            it 'has the note name for the index' do
              expect(scale.note_name(-17)).to eq("C")
              expect(scale.note_name(-16)).to eq("C#")
              expect(scale.note_name(-15)).to eq("Db")
              expect(scale.note_name(-14)).to eq("D")
              expect(scale.note_name(-13)).to eq("D#")
              expect(scale.note_name(-12)).to eq("Eb")
              expect(scale.note_name(-11)).to eq("E")
              expect(scale.note_name(-10)).to eq("F")
              expect(scale.note_name(-9)).to eq("F#")
              expect(scale.note_name(-8)).to eq("Gb")
              expect(scale.note_name(-7)).to eq("G")
              expect(scale.note_name(-6)).to eq("G#")
              expect(scale.note_name(-5)).to eq("Ab")
              expect(scale.note_name(-4)).to eq("A")
              expect(scale.note_name(-3)).to eq("A#")
              expect(scale.note_name(-2)).to eq("Bb")
              expect(scale.note_name(-1)).to eq("B")
              expect(scale.note_name(0)).to eq("C")
              expect(scale.note_name(1)).to eq("C#")
              expect(scale.note_name(2)).to eq("Db")
              expect(scale.note_name(3)).to eq("D")
              expect(scale.note_name(4)).to eq("D#")
              expect(scale.note_name(5)).to eq("Eb")
              expect(scale.note_name(6)).to eq("E")
              expect(scale.note_name(7)).to eq("F")
              expect(scale.note_name(8)).to eq("F#")
              expect(scale.note_name(9)).to eq("Gb")
              expect(scale.note_name(10)).to eq("G")
              expect(scale.note_name(11)).to eq("G#")
              expect(scale.note_name(12)).to eq("Ab")
              expect(scale.note_name(13)).to eq("A")
              expect(scale.note_name(14)).to eq("A#")
              expect(scale.note_name(15)).to eq("Bb")
              expect(scale.note_name(16)).to eq("B")
            end
          end

          describe '#size' do
            it 'has the size we expect' do
              expect(scale.size).to eq(17)
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
              expect(scale.notes.size).to eq(17)
            end
          end

          describe '#sorted_notes' do
            it 'is an Array' do
              expect(scale.sorted_notes).to be_a(Array)
            end

            it 'has the expected size' do
              expect(scale.sorted_notes.size).to eq(17)
            end
          end

          describe '#sort' do
            it 'is an Array' do
              expect(scale.sort).to be_a(Array)
            end

            it 'has the scale\'s size' do
              expect(scale.sort.size).to eq(17)
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
              expect(scale.note_names).to eq(%w{ C C# Db D D# Eb E F F# Gb G G# Ab A A# Bb B })
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
              expect(scale.note_types).to eq(["1", nil, nil, "2", nil, nil, "M3",
                "4", nil, nil, "5", nil, nil, "M6", nil, nil, "M7"])
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
      end
    end
  end
end
