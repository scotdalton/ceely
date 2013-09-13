require 'spec_helper'
module Ceely
  require 'pry'
  describe NoAssignmentError do
    subject(:error) { NoAssignmentError.new }

    describe '#message' do
      it 'has the default message' do
        expect(error.message).to eql("Looks like you didn't do your assignment.")
      end
    end
  end

  describe 'Assignment with defaults' do
    subject(:assignment) { Assignment.new("Assignment Name") }

    describe '#name' do
      it 'has the name that it was initialized with' do
        expect(assignment.name).to eql("Assignment Name")
      end
    end

    describe '#width' do
      it 'has the default width' do
        expect(assignment.width).to eq(300)
      end
    end

    describe '#height' do
      it 'has the default height' do
        expect(assignment.height).to eq(300)
      end
    end

    describe '#run' do
      context 'when no block is passed' do
        it 'raises a NoAssignmentError' do
          expect{ assignment.run }.to raise_error(NoAssignmentError)
        end
      end
    end
  end

  describe 'Assignment with width and height specified' do
    subject(:assignment) { Assignment.new("Assignment Name", 200, 400) }

    describe '#width' do
      it 'has the width that it was initialized with' do
        expect(assignment.width).to eq(200)
      end
    end

    describe '#height' do
      it 'has the height that it was initialized with' do
        expect(assignment.height).to eq(400)
      end
    end
  end
end
