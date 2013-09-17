require 'spec_helper'
module Ceely
  describe Note do
    context "when a valid frequency is given" do
      subject(:note) { Note.new(440) }

      describe '#frequency' do
        it 'has the frequency that we expect' do
          expect(note.frequency).to eq(440)
        end
      end

      describe '#pitch' do
        it 'has the pitch that we expect' do
          expect(note.pitch).to eq(69)
        end
      end

      # Don't run this test on travis since
      # we don't have permissions.
      unless(ENV['TRAVIS'].eql? "true")
        describe '#play' do
          it 'plays for 5 seconds' do
            expect { note.play(5, 50) }.not_to raise_error
          end
        end
      end
    end

    context "when a non number frequency is given" do
      describe '.new' do
        it 'raises an error' do
          expect{ Note.new("Invalid frequency") }.to raise_error(ArgumentError)
        end
      end
    end

    context "when a negative number frequency is given" do
      describe '.new' do
        it 'raises an error' do
          expect{ Note.new(-100) }.to raise_error(ArgumentError)
        end
      end
    end
  end
end
