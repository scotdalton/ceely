module Ceely
  module Interval
    # An Interval is a Note that takes a fundamental note, an index and a factor
    # This is the Base class.
    class Base
      attr_reader :fundamental, :index

      def initialize(fundamental, index)
        @fundamental, @index = fundamental, index
      end

      def frequency
        @frequency ||= (fundamental.frequency * factor).to_f
      end

      # Get the note for this interval
      def note
        @note ||= Note.new(frequency)
      end

      # "Basic miracle of music"
      # http://en.wikipedia.org/wiki/Octave
      # Returns the number of the octave that the frequency is in
      # First octave is 0
      def octave
        @octave ||= Math.log2(frequency/fundamental.frequency).floor
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
          octave_adjusted_factor.to_f * fundamental.frequency
      end

      def octave_adjusted_note
        @octave_adjusted_note ||= Note.new(octave_adjusted_frequency)
      end

      def to_s
        @s ||= clean %Q{
          Index: #{index}
          Factor: #{factor}
          Fundamental Frequency: #{fundamental.frequency}
          Frequency: #{frequency}
          Octave: #{octave}
          Octave Adjusted Denominator: #{octave_adjusted_denominator}
          Octave Adjusted Factor: #{octave_adjusted_factor}
          Octave Adjusted Frequency: #{octave_adjusted_frequency}
        }
      end

      def clean(string)
        string.strip.gsub(/^\s*/, "\t")
      end
      protected :clean
    end
  end
end
