require 'spec_helper'
module Ceely
  module Pythagorean
    describe Ceely::Pythagorean::Note do
      pythagorean["notes"].each do |index, expected_values|
        # Set the expected values
        expected_fundamental_frequency = 528.0
        expected_factor = expected_values["factor"]
        expected_factor_array = expected_factor.split("/")
        expected_factor_num = expected_factor_array.first
        expected_factor_den = expected_factor_array.last
        expected_frequency = expected_values["frequency"]
        expected_octave = expected_values["octave"]
        expected_octave_adjusted_denominator = expected_values["octave_adjusted_denominator"]
        expected_octave_adjusted_factor = expected_values["octave_adjusted_factor"]
        expected_octave_adjusted_frequency = expected_values["octave_adjusted_frequency"]
        context "when it's the #{index} note note," do
          subject(:note) { Ceely::Pythagorean::Note.new(528.0, index) }

          describe '#index' do
            it 'has the index that we expect' do
              expect(note.index).to eq(index)
            end
          end

          describe '#frequency' do
            it 'has the frequency that we expect' do
              expect(note.frequency).to eq(expected_frequency)
            end
          end

          describe '#factor' do
            it 'has the factor we expect' do
              expect(note.factor).to be_a(Rational)
              expect(note.factor).to eq(Rational(expected_factor_num, expected_factor_den))
              expect("#{note.factor}").to eq(expected_factor)
            end
          end

          describe '#tone' do
            it 'has the tone that we expect' do
              expect(note.tone).to eq(Tone.new expected_frequency)
            end
          end

          describe '#octave' do
            it 'is the octave we expect' do
              expect(note.octave).to eq(expected_octave)
            end
          end

          describe '#octave_adjusted_denominator' do
            it 'is the octave denominator we expect' do
              expect(note.octave_adjusted_denominator).to eq(expected_octave_adjusted_denominator)
            end
          end

          describe '#octave_adjusted_factor' do
            it 'has the octave adjusted factor we expect' do
              expect(note.octave_adjusted_factor.to_f).to eq(expected_octave_adjusted_factor)
              # expect("#{note.octave_adjusted_factor}").to eq(expected_octave_adjusted_factor)
            end
          end

          describe '#octave_adjusted_frequency' do
            it 'has the octave_adjusted_frequency that we expect' do
              expect(note.octave_adjusted_frequency).to eq(expected_octave_adjusted_frequency)
            end
          end

          describe '#octave_adjusted_tone' do
            it 'has the octave_adjusted_tone that we expect' do
              expect(note.octave_adjusted_tone).to eq(Tone.new expected_octave_adjusted_frequency)
            end
          end

          # describe '#to_s' do
          #   it 'goes to string as we expect' do
          #     expect(note.to_s).to eql("Note:\n" + %Q{
          #       Index: #{index}
          #       Factor: #{expected_factor}
          #       Fundamental Frequency: #{expected_fundamental_frequency}
          #       Frequency: #{expected_frequency}
          #       Octave: #{expected_octave}
          #       Octave Adjusted Denominator: #{expected_octave_adjusted_denominator}
          #       Octave Adjusted Factor: #{expected_octave_adjusted_factor}
          #       Octave Adjusted Frequency: #{expected_octave_adjusted_frequency}
          #     }.strip.gsub(/^\s*/, "\t"))
          #   end
          # end
        end
      end

      context "when it's the natural pitches," do
        subject(:c) { Ceely::Pythagorean::Note.new(528.0, 0, "C") }
        subject(:d) { Ceely::Pythagorean::Note.new(528.0, 2, "D") }
        subject(:e) { Ceely::Pythagorean::Note.new(528.0, 4, "E") }
        subject(:f) { Ceely::Pythagorean::Note.new(528.0, -1, "F") }
        subject(:g) { Ceely::Pythagorean::Note.new(528.0, 1, "G") }
        subject(:a) { Ceely::Pythagorean::Note.new(528.0, 3, "A") }
        subject(:b) { Ceely::Pythagorean::Note.new(528.0, 5, "B") }
        
        describe '#interval from c to d' do
          it 'has the interval that we expect' do
            expect(c.interval(d)).to eq(Rational(9, 8))
          end
        end

        describe '#interval from d to e' do
          it 'has the interval that we expect' do
            expect(d.interval(e)).to eq(Rational(9, 8))
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

        describe '#interval from g to a' do
          it 'has the interval that we expect' do
            expect(g.interval(a)).to eq(Rational(9, 8))
          end
        end

        describe '#interval from a to b' do
          it 'has the interval that we expect' do
            expect(a.interval(b)).to eq(Rational(9, 8))
          end
        end
      end
    end
  end
end
