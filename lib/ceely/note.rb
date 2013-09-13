module Ceely
  require 'jsound'
  require 'pry'
  class Note
    include JSound
    attr_reader :pitch, :instrument

    # Pitch is in MIDI terms
    # Default output to simple synth.
    # output=/SimpleSynth/
    def initialize(pitch, instrument=Instrument.new)
      @pitch, @instrument = pitch, instrument
    end

    def simple_synth
      @simple_synth ||= Midi::OUTPUTS.find /SimpleSynth/
    end

    def synthesizer
      @synthesizer ||= Midi::DEVICES.find /Software wavetable synthesizer/
    end

    def sequencer
      @sequencer ||= Midi::DEVICES.find /Software sequencer/
    end

    def sequence
      @sequence ||= Midi::Sequence.new(Midi::Sequence::PPQ, 10)
    end

    def generator
      @generator ||= Midi::Devices::Generator.new
    end

    def play(&block)
      start
      yield if block_given?
      stop
    end

    def play_simple_synth(&block)
      start_simple_synth
      yield if block_given?
      stop_simple_synth
    end

    def start
      synthesizer.open
      synthesizer.load_all_instruments instrument.soundbank
      current_channel = synthesizer.channels.first
      current_channel.program_change instrument.bank, instrument.program
      current_channel.solo= true
      current_channel.noteOn(pitch, 127)
    end

    def stop
      synthesizer.channels.first.noteOff(pitch)
      synthesizer.close
    end

    def start_simple_synth
      simple_synth.open
      generator >> simple_synth
      generator.note_on pitch
    end

    def stop_simple_synth
      generator.note_off pitch
      simple_synth.close
    end

    def frequency
      @frequency ||= 440 * 2**((pitch - 69) / 12)
    end
  end
end