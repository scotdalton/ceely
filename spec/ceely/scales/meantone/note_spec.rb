require 'spec_helper'
module Ceely
  module Scales
    module Meantone
      describe Ceely::Scales::Meantone::Note do
        meantone["notes"].each do |index, expected_values|
          # Set the expected values
          expected_octave_adjusted_factor = expected_values["octave_adjusted_factor"]

          context "when it's the #{index} note note," do
            subject(:scale) { Ceely::Scales::Meantone::Scale.new(528.0) }
            subject(:note) { scale.note_by_index(index) }

            describe '#index' do
              it "has #{index} as the index" do
                expect(note.index).to eq(index)
              end
            end

            describe '#octave_adjusted_factor' do
              it "has #{expected_octave_adjusted_factor} as the octave adjusted factor" do
                expect(note.octave_adjusted_factor.to_f).to be_within(0.0175).of(expected_octave_adjusted_factor)
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
