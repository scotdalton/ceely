module Ceely
  # An Note takes a fundamental frequency, an index and an optional name
  class Note
    FACTOR_ERROR = -> {
      raise NotImplementedError.new("Factor should be callable, stretch.") }
    
    include Comparable
    include Ceely::Mixins::Playable

    attr_reader :fundamental_frequency, :index
    attr_accessor :name, :type
    attr_reader :octave

    def initialize(fundamental_frequency, factor, *args)
      @fundamental_frequency, @factor = fundamental_frequency, factor
      @index = (args.shift || 0)
      @octave = (args.shift || 0)
      @name = args.shift
      @type = args.shift
      @duration = (args.shift || 0.5)
    end

    def in_octave(octave)
      self.class.new @fundamental_frequency, -> note{ factor },
        @index, octave, @name,@type, @duration
    end

    def raw_frequency
      @raw_frequency ||= (fundamental_frequency * factor)
    end

    # Get the raw tone for this note
    def raw_tone
      @raw_tone ||= Tone.new(raw_frequency, duration)
    end

    # "Basic miracle of music"
    # http://en.wikipedia.org/wiki/Octave
    # Returns the number of the octave that the frequency is in
    # First octave is 0
    def raw_octave
      @raw_octave ||= Math.log2(raw_frequency/fundamental_frequency).floor
    end

    # Factor should be a lambda
    def factor
      FACTOR_ERROR.call unless @factor.respond_to? :call
      @_factor ||= @factor.call(self)
    end

    def octave_adjusted_denominator
      @octave_adjusted_denominator ||= 2**(raw_octave)
    end

    def octave_adjusted_factor
      @octave_adjusted_factor ||= Rational((2**octave)*factor, octave_adjusted_denominator)
    end

    def frequency
      @frequency ||= octave_adjusted_factor * fundamental_frequency
    end

    def tone
      @tone ||= Tone.new(frequency, duration)
    end

    def play(amplitude)
      tone.duration = duration
      tone.play(amplitude)
    end

    def <=>(other_note)
      tone <=> other_note.tone
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
      other_note ||= self.class.new(@fundamental_frequency, @factor, 0)
      # Handle the octave
      # If the frequencies are the same we're either dealing with
      # the same note or the note in a different octave. Either way 
      # let's just deal with the raw frequencies, not the octave adjusted
      # factors.  If they're the same, it'll just be 1, so no harm,
      # no foul.  If they're different, this should give us the proper
      # interval.
      Rational(other_note.octave_adjusted_factor, self.octave_adjusted_factor)
    end

    def to_s
      @s ||= (type || name || index)
    end

    def clean(string)
      string.strip.gsub(/^\s*/, "\t")
    end
    protected :clean
  end
end
