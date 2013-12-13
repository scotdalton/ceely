module Ceely
  class Tone
    include Comparable
    include Ceely::Mixins::Playable

    attr_reader :frequency

    # Frequency in Hz
    # Raises an error if it's not a valid number
    def initialize(frequency, duration)
      raise ArgumentError.new("Must be a number") unless frequency.is_a? Numeric
      raise ArgumentError.new("Must be a positive number") unless frequency >= 0
      @frequency, @duration = frequency, duration
    end

    # Play the tone
    # at the specified amplitude
    def play(amplitude)
      play_tone(self, amplitude)
    end

    # Angular frequency of the tone
    # http://en.wikipedia.org/wiki/Angular_frequency
    def angular_frequency
      @angular_frequency ||= 2.0 * Math::PI * frequency
    end

    def to_s
      "#{self.class}:\n\tfrequecy: #{frequency}\n\tduration: #{duration}"
    end

    # Tones are == if they have the same frequency and duration
    def ==(other_tone)
      frequency == other_tone.frequency and duration == other_tone.duration
    end

    # Tones are eql if they are the same class
    # and are ==
    def eql?(other_tone)
      other_tone.instance_of?(self.class) and self == other_tone
    end

    # Compare tones by their frequencies
    def <=>(other_tone)
      frequency <=> other_tone.frequency
    end
  end
end
