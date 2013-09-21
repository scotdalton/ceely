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

    # Pitch in MIDI terms
    def pitch
      @pitch ||= 69 + 12*(Math.log2(frequency/440))
    end

    def to_s
      "Note with frequency #{frequency}"
    end

    # Notes are equal if they have the same frequency
    def ==(other_note)
      (other_note.is_a? self.class and frequency == other_note.frequency)
    end
    alias :eql? :==
  end
end
