require 'spec_helper'
module Ceely
  module EvenTempered
    describe Ceely::EvenTempered::Note do
      even_tempered["notes"].each do |index, expected_values|

        # Set the expected values
        expected_frequency = expected_values["frequency"]
        expected_cents = index*100

        context "when it's the #{index} even tempered note," do
          subject(:note) { Ceely::EvenTempered::Note.new(528.0, index) }

          describe '#index' do
            it 'has the index that we expect' do
              expect(note.index).to eq(index)
            end
          end

          describe '#frequency' do
            it 'has the frequency that we expect' do
              expect(note.frequency).to be_within(0.0001).of(expected_frequency)
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