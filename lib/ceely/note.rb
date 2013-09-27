module Ceely
  # An Note takes a fundamental frequency, an index and an optional name
  class Note
    include Comparable

    attr_reader :fundamental_frequency, :index
    attr_accessor :name

    def initialize(fundamental_frequency, index=0, name=nil)
      @fundamental_frequency, @index, @name = fundamental_frequency, index, name
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

    def to_s
      @s ||= "Note:\n"+
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
