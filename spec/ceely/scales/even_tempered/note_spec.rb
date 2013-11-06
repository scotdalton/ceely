require 'spec_helper'
module Ceely
  module Scales
    module EvenTempered
      describe Ceely::Scales::EvenTempered::Note do
        even_tempered["notes"].each do |index, expected_values|

          # Set the expected values
          expected_raw_frequency = expected_values["raw_frequency"]
          expected_cents = index*100

          context "when it's the #{index} even tempered note," do
            subject(:note) { Ceely::Scales::EvenTempered::Note.new(528.0, index) }

            describe '#index' do
              it 'has the index that we expect' do
                expect(note.index).to eq(index)
              end
            end

            describe '#raw_frequency' do
              it 'has the rawfrequency that we expect' do
                expect(note.raw_frequency).to be_within(0.0001).of(expected_raw_frequency)
              end
            end

            describe '#cents' do
              it 'has the cents that we expect' do
                expect(note.cents).to be_within(0.0001).of(expected_cents)
              end
            end
          end
        end
      end
    end
  end
end
