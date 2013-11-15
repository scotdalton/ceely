module Ceely
  # An Note takes a fundamental frequency, an index and an optional name
  class Note
    include Comparable
    include Ceely::Mixins::Playable

    attr_reader :fundamental_frequency, :index
    attr_accessor :name, :type
    attr_writer :octave

    def initialize(fundamental_frequency, *args)
      index = (args.shift || 0)
      name = args.shift
      type = args.shift
      duration = (args.shift || 0.5)
      @fundamental_frequency, @index = fundamental_frequency, index
      @name, @type, @duration = name, type, duration
    end

    def becomes(note_class)
      note_class.new(fundamental_frequency, index, name, type)
    end

    def in_octave(octave)
      self.class.new(frequency*(2**octave), 0, name, type)
    end

    def flatten(interval)
      self.class.new(frequency*(1/interval), 0, "#{name} b")
    end

    def sharpen(interval)
      self.class.new(frequency*interval, 0, "#{name} #")
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
    def octave
      @octave ||= Math.log2(raw_frequency/fundamental_frequency).floor
    end

    # Intended to be overridden by subclasses
    def factor
      raise NotImplementedError.new("You should implement factor, stretch.")
    end

    def octave_adjusted_denominator
      @octave_adjusted_denominator ||= 2**(octave)
    end

    def octave_adjusted_factor
      @octave_adjusted_factor ||= Rational(factor, octave_adjusted_denominator)
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
      other_note ||= self.class.new(fundamental_frequency, 0)
      # Handle the octave
      # If the frequencies are the same we're either dealing with
      # the same note or the note in a different octave. Either way 
      # let's just deal with the raw frequencies, not the octave adjusted
      # factors.  If they're the same, it'll just be 1, so no harm,
      # no foul.  If they're different, this should give us the proper
      # interval.
      if frequency.to_i == other_note.frequency.to_i
        Rational(other_note.raw_frequency, self.raw_frequency)
      else
        Rational(other_note.octave_adjusted_factor, self.octave_adjusted_factor)
      end
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
