require 'spec_helper'
module Ceely
  describe 'Instrument with default soundbank' do
    subject(:instrument) { Instrument.new(0, 0) }

    describe '#bank' do
      it 'has the bank that we expect' do
        expect(instrument.bank).to eq(0)
      end
    end

    describe '#program' do
      it 'has the program that we expect' do
        expect(instrument.program).to eq(0)
      end
    end

    describe '#soundbank' do
      it 'has the default soundbank' do
        expect(instrument.soundbank_name).to eql('soundbank-min')
      end
    end

    describe '#midfiy' do
      it 'midifies without errors' do
        expect { instrument.midify }.not_to raise_error
      end

      it 'midifies without errors' do
        expect(instrument.midify).to be_a(JSound::Midi::Instrument)
      end
    end
  end
end
