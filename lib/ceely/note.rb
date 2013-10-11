module Ceely
  # An Note takes a fundamental frequency, an index and an optional name
  class Note
    include Comparable

    attr_reader :fundamental_frequency, :index
    attr_accessor :name

    def initialize(fundamental_frequency, index=0, name=nil)
      @fundamental_frequency, @index, @name = fundamental_frequency, index, name
    end

    def in_octave(octave)
      return self.class.new(octave_adjusted_frequency*(2**octave), 0, name)
    end

    def frequency
      @frequency ||= (fundamental_frequency * factor).to_f
    end

    # Get the tone for this note
    def tone
      @tone ||= Tone.new(frequency)
    end

    # "Basic miracle of music"
    # http://en.wikipedia.org/wiki/Octave
    # Returns the number of the octave that the frequency is in
    # First octave is 0
    def octave
      @octave ||= Math.log2(frequency/fundamental_frequency).floor
    end

    # Intended to be overridden by subclasses
    def factor
      raise NotImplementedError.new("You should implement factor denominator, stretch.")
    end

    def octave_adjusted_denominator
      @octave_adjusted_denominator ||= 2**(octave)
    end

    def octave_adjusted_factor
      @octave_adjusted_factor ||= Rational(factor, octave_adjusted_denominator)
    end

    def octave_adjusted_frequency
      @octave_adjusted_frequency ||= 
        octave_adjusted_factor.to_f * fundamental_frequency
    end

    def octave_adjusted_tone
      @octave_adjusted_tone ||= Tone.new(octave_adjusted_frequency)
    end

    def <=>(other_note)
      octave_adjusted_tone <=> other_note.octave_adjusted_tone
    end

    # Cents is the interval between the fundamental note and this note
    def cents
      @cents ||= interval_in_cents
    end

    # If we know the frequencies a and b of two notes, 
    # the number of cents measuring the interval from a to b may be calculated
    # by the following formula: 1200*log2(b/a)
    # http://en.wikipedia.org/wiki/Cent_(music)
    def interval_in_cents(other_note=nil)
      (1200*Math.log2(Rational(1.0, interval(other_note)))).abs
    end

    # Returns the interval between this note and another note.
    def interval(other_note=nil)
      other_note ||= self.class.new(fundamental_frequency, 0)
      # Handle the octave
      # If the octave adjusted frequencies are the same
      # we're either dealing with the same note or the note in
      # a different octave. Either way let's just deal with the 
      # factors, not the octave adjusted factors.  If they're the 
      # same, it'll just be 1, so no harm, no foul.  If they're
      # different, this should give us the proper interval.
      if octave_adjusted_frequency.to_i == other_note.octave_adjusted_frequency.to_i
        Rational(other_note.factor, self.factor)
      else
        Rational(other_note.octave_adjusted_factor, self.octave_adjusted_factor)
      end
    end

    def to_s
      @s ||= "Note#{" " + name if name}:\n"+
        clean(%Q{
          Index: #{index}
          Factor: #{factor}
          Fundamental Frequency: #{fundamental_frequency}
          Frequency: #{frequency}
          Octave: #{octave}
          Octave Adjusted Denominator: #{octave_adjusted_denominator}
          Octave Adjusted Factor: #{octave_adjusted_factor}
          Octave Adjusted Frequency: #{octave_adjusted_frequency}
        })
    end

    def clean(string)
      string.strip.gsub(/^\s*/, "\t")
    end
    protected :clean
  end
end
