module Ceely
  require 'pry'
  class Tone
    include Comparable

    attr_reader :frequency

    # Frequency in Hz
    # Raises an error if it's not a valid number
    def initialize(frequency)
      raise ArgumentError.new("Must be a number") unless frequency.is_a? Numeric
      raise ArgumentError.new("Must be a positive number") unless frequency >= 0
      @frequency = frequency
    end

    # Play the tone for the given number of seconds
    # at the specified amplitude
    def play(seconds, amplitude)
      player.play(self, seconds, amplitude)
    end

    # Angular frequency of the tone
    # http://en.wikipedia.org/wiki/Angular_frequency
    def angular_frequency
      @angular_frequency ||= 2.0 * Math::PI * frequency
    end

    # New player with default settings
    def player
      @player ||= Player.new
    end

    def to_s
      "Tone with frequency #{frequency}"
    end

    # Tones are equal if they have the same frequency
    def ==(other_tone)
      (other_tone.is_a? self.class and frequency == other_tone.frequency)
    end
    alias :eql? :==

    # Compare tones by their frequencies
    def <=>(other_tone)
      frequency <=> other_tone.frequency
    end
  end
end
