module Ceely
  require 'jsound'
  class Instrument
    # http://en.wikipedia.org/wiki/General_MIDI_Level_2#Program_and_bank_change_events
    attr_reader :bank, :program, :soundbank_name

    def initialize(bank=0, program=0, soundbank_name='soundbank-min')
      @bank, @program, @soundbank_name = bank, program, soundbank_name
    end

    def soundbank_file
      @soundbank_file ||= File.new("#{File.dirname(__FILE__)}/../../soundbanks/#{soundbank_name}.gm")
    end

    def soundbank
      @soundbank ||= JSound::Midi::MidiSystem.get_soundbank(soundbank_file.to_inputstream)
    end

    def patch
      @patch ||= JSound::Midi::Patch.new(bank, program)
    end

    def midify
      @midify ||= soundbank.get_instrument(patch)
    end
  end
end