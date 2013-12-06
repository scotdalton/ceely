require 'spec_helper'
module Ceely
  module Scales
    module Rameau
      describe Ceely::Scales::Rameau::Note do
        context "when it's a basic note," do
          subject(:note) { Ceely::Scales::Rameau::Note.new(528.0, nil) }

          describe "#dominant" do
            it 'is 3/2' do
              expect(note.dominant).to eq(Rational(3, 2))
            end
          end

          describe "#subdominant" do
            it 'is 4/3' do
              expect(note.subdominant).to eq(Rational(4, 3))
            end
          end

          describe "#just_wholetone" do
            it 'is 9/8' do
              expect(note.just_wholetone).to eq(Rational(9, 8))
            end
          end

          describe "#just_semitone" do
            it 'is 9/8' do
              expect(note.just_semitone).to eq(Rational(16, 15))
            end
          end
        end
        rameau["notes"].each do |name, expected_values|
          # Set the expected values
          expected_fundamental_frequency = 528.0
          expected_factor = Rational(expected_values["factor"])
          expected_octave_adjusted_factor = Rational(expected_values["octave_adjusted_factor"])
          expected_interval = Rational(expected_values["interval"])
          expected_cents = expected_values["cents"]
          expected_frequency = expected_values["frequency"]

          context "when it's the #{name} note," do
            subject(:scale) { Ceely::Scales::Rameau::Scale.new(528.0) }
            subject(:note) { scale.note_by_name(name) }

            describe '#factor' do
              it "has #{expected_factor} as the factor" do
                expect(note.factor).to be_a(Rational)
                expect(note.factor).to eq(expected_factor)
              end
            end

            describe '#octave_adjusted_factor' do
              it "has #{expected_octave_adjusted_factor} as the octave adjusted factor" do
                expect(note.octave_adjusted_factor).to be_a(Rational)
                expect(note.octave_adjusted_factor).to eq(expected_octave_adjusted_factor)
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
      end
    end
  end
end
