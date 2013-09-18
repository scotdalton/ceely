module Ceely
  require 'jsound'
  require 'pry'
  class Note
    include JSound
    attr_reader :frequency

    # Frequency in Hz
    # Raises an error if it's not a valid number
    def initialize(frequency)
      raise ArgumentError.new("Must be a number") unless frequency.is_a? Numeric
      raise ArgumentError.new("Must be a positive number") unless frequency >= 0
      @frequency = frequency
    end

    # Play the note for the given number of seconds
    # at the specified amplitude
    def play(seconds, amplitude)
      player.play(self, seconds, amplitude)
    end

    # Angular frequency of the note
    # http://en.wikipedia.org/wiki/Angular_frequency
    def angular_frequency
      @angular_frequency ||= 2.0 * Math::PI * frequency
    end

    # New player with default settings
    def player
      @player ||= Player.new
    end

    # MIDI playback
    def play_midi(duration, output)
      output.open
      generator >> output
      generator.note_on pitch
      sleep duration
      generator.note_off pitch
      output.close
    end

    # Pitch in MIDI terms
    def pitch
      @pitch ||= 69 + 12*(Math.log2(frequency/440))
    end

    def generator
      @generator ||= Midi::Devices::Generator.new
    end
    private :generator
  end
end