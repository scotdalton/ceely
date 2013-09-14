module Ceely
  require 'jsound'
  require 'pry'
  class Note
    include JSound
    attr_reader :frequency

    # Frequency in Hz
    def initialize(frequency)
      @frequency = frequency
    end

    def player
      @player ||= Sampled::Player.new
    end

    def play(duration)
      player.play(self, duration)
    end

    # MIDI playback
    def play_midi(duration, output=nil)
      output = Midi::OUTPUTS.first if output.nil?
      output.open
      generator >> simple_synth
      start_midi(output)
      sleep duration
      stop_midi(output)
    end

    def start_midi(output)
      generator.note_on pitch
    end

    def stop_midi(output)
      generator.note_off pitch
      output.close
    end

    def generator
      @generator ||= Midi::Devices::Generator.new
    end

    # Pitch is in MIDI terms
    def pitch
      # TODO convert from frequency for MIDI
    end

  end
end