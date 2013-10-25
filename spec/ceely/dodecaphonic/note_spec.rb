require 'spec_helper'
module Ceely
  module Dodecaphonic
    describe Ceely::Dodecaphonic::Note do
      dodecaphonic["notes"].each do |index, expected_values|
        # Set the expected values
        expected_fundamental_frequency = 528.0
        expected_factor = expected_values["factor"]
        expected_factor_array = expected_factor.split("/")
        expected_factor_num = expected_factor_array.first
        expected_factor_den = expected_factor_array.last
        expected_raw_frequency = expected_values["raw_frequency"]
        expected_octave = expected_values["octave"]
        expected_octave_adjusted_denominator = expected_values["octave_adjusted_denominator"]
        expected_octave_adjusted_factor = expected_values["octave_adjusted_factor"]
        expected_frequency = expected_values["frequency"]
        # expected_cents = expected_values["cents"]

        context "when it's the #{index} note note," do
          subject(:note) { Ceely::Dodecaphonic::Note.new(528.0, index) }

          describe '#index' do
            it 'has the index that we expect' do
              expect(note.index).to eq(index)
            end
          end

          describe '#raw_frequency' do
            it 'has the raw_frequency that we expect' do
              expect(note.raw_frequency).to eq(expected_raw_frequency)
            end
          end

          describe '#factor' do
            it 'has the factor we expect' do
              expect(note.factor).to be_a(Rational)
              expect(note.factor).to eq(Rational(expected_factor_num, expected_factor_den))
              expect("#{note.factor}").to eq(expected_factor)
            end
          end

          describe '#raw_tone' do
            it 'has the raw tone that we expect' do
              expect(note.raw_tone).to eq(Tone.new(expected_raw_frequency, 0.5))
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

          describe '#frequency' do
            it 'has the frequency that we expect' do
              expect(note.frequency).to eq(expected_frequency)
            end
          end

          describe '#tone' do
            it 'has the tone that we expect' do
              expect(note.tone).to eq(Tone.new(expected_frequency, 0.5))
            end
          end

          # Don't run this test on travis since
          # we don't have permissions.
          unless(ENV['TRAVIS'].eql? "true")
            describe '#play' do
              it 'does not raises an error' do
                expect{ note.play(50) }.not_to raise_error
              end
            end
          end
        end
      end

      context "when it's the dodecaphonic pitches," do
        subject(:c) { Ceely::Dodecaphonic::Note.new(528.0, 0, "C") }
        subject(:d_flat) { Ceely::Dodecaphonic::Note.new(528.0, -5, "Db") }
        subject(:d) { Ceely::Dodecaphonic::Note.new(528.0, 2, "D") }
        subject(:e_flat) { Ceely::Dodecaphonic::Note.new(528.0, -3, "Eb") }
        subject(:e) { Ceely::Dodecaphonic::Note.new(528.0, 4, "E") }
        subject(:f) { Ceely::Dodecaphonic::Note.new(528.0, -1, "F") }
        subject(:g_flat) { Ceely::Dodecaphonic::Note.new(528.0, -6, "Gb") }
        subject(:f_sharp) { Ceely::Dodecaphonic::Note.new(528.0, 6, "F#") }
        subject(:g) { Ceely::Dodecaphonic::Note.new(528.0, 1, "G") }
        subject(:a_flat) { Ceely::Dodecaphonic::Note.new(528.0, -4, "Ab") }
        subject(:a) { Ceely::Dodecaphonic::Note.new(528.0, 3, "A") }
        subject(:b_flat) { Ceely::Dodecaphonic::Note.new(528.0, -2, "Bb") }
        subject(:b) { Ceely::Dodecaphonic::Note.new(528.0, 5, "B") }
        
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
