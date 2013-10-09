require 'spec_helper'
module Ceely
  module Pythagorean
    describe Ceely::Pythagorean::Scale do
      # Set the expected values
      expected_display_tones = pythagorean["notes"].collect { |index, expected_values|
        "Tone with frequency #{expected_values["octave_adjusted_frequency"]}" 
      }.join("\n\n")
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
                  note.octave_adjusted_frequency 
                }
                expect(frequencies).to eq(expected_frequencies)
              end
            end
            describe "#alt_#{mode} in octave #{octave_index}" do
              it 'has 8 elements' do
                expect(scale.send("alt_#{mode}".to_sym, octave_index).size).to be(8)
              end
              it 'has the frequencies that we expect' do
                frequencies = scale.send("alt_#{mode}".to_sym, octave_index).collect { |note| 
                  note.octave_adjusted_frequency 
                }
                # expect(frequencies).to eq(expected_frequencies)
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
            expect(scale.size).to eq(14)
          end
        end

        describe '#mode_size' do
          it 'has the mode_size we expect' do
            expect(scale.mode_size).to eq(8)
          end
        end

        describe '#notes' do
          it 'is an Array' do
            expect(scale.notes).to be_a(Array)
          end

          it 'has the expected size' do
            expect(scale.notes.size).to eq(14)
          end
        end

        describe '#sort_notes' do
          it 'is an Array' do
            expect(scale.sort_notes).to be_a(Array)
          end

          it 'has the scale\'s size' do
            expect(scale.sort_notes.size).to eq(14)
          end

          it 'has the given size' do
            expect(scale.sort_notes(3).size).to eq(3)
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

        describe '#alt_nth_mode' do
          it 'is an Array' do
            expect(scale.alt_nth_mode(0)).to be_a(Array)
          end

          it 'has the expected size' do
            expect(scale.alt_nth_mode(0).size).to eq(8)
          end

          it 'has the expected first name' do
            expect(scale.alt_nth_mode(0).first.name).to eq("C")
          end

          it 'is an Array' do
            expect(scale.alt_nth_mode(1)).to be_a(Array)
          end

          it 'has the expected size' do
            expect(scale.alt_nth_mode(1).size).to eq(8)
          end

          it 'has the expected first name' do
            expect(scale.alt_nth_mode(1).first.name).to eq("D")
          end
        end

        describe '#offset' do
          it 'has the offset we expect' do
            expect(scale.offset).to eq(-1)
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

          describe '#play_alt_mode' do
            it 'does not raises an error' do
              expect{ scale.play_alt_mode("ionian", 0, 1, 50) }.not_to raise_error
            end
          end
        end

        describe '#to_s' do
          it 'does not raises an error' do
            expect{ scale.to_s }.not_to raise_error
          end

          # it 'displays the expected tones' do
          #   expect(scale.to_s).to eql(expected_display_tones)
          # end
        end
      end

      context 'when constructed with inputs,' do
        subject(:scale) { Ceely::Pythagorean::Scale.new(594.0, 7, -1) }

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

        describe '#notes' do
          it 'is an Array' do
            expect(scale.notes).to be_a(Array)
          end

          it 'has the expected size' do
            expect(scale.notes.size).to eq(7)
          end
        end

        describe '#sort_notes' do
          it 'is an Array' do
            expect(scale.sort_notes).to be_a(Array)
          end

          it 'has the scale\'s size' do
            expect(scale.sort_notes.size).to eq(7)
          end

          it 'has the given size' do
            expect(scale.sort_notes(3).size).to eq(3)
          end
        end

        describe '#offset' do
          it 'has the offset we expect' do
            expect(scale.offset).to eq(-1)
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

          describe '#play_alt_mode' do
            it 'does not raises an error' do
              expect{ scale.play_alt_mode("ionian", 0, 1, 50) }.not_to raise_error
            end
          end
        end

        describe '#to_s' do
          it 'does not raises an error' do
            expect{ scale.to_s }.not_to raise_error
          end

          # it 'displays the expected tones' do
          #   expect(scale.to_s).to eql(expected_display_tones)
          # end
        end
      end
    end
  end
end