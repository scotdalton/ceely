module Ceely
  # A NoteRelation is a Note that takes a base note, a relation number
  # an interval factor
  class NoteRelation < Note
    attr_reader :base, :relation, :interval_factor

    def initialize(base, relation, interval_factor)
      @base, @relation, @interval_factor = base, relation, interval_factor
      super((base.frequency * interval_factor).to_f)
    end

    # Intended to be overridden by subclasses
    def octave
    end

    # Intended to be overridden by subclasses
    def octave_denominator
    end

    def octave_ratio
      @octave_ratio ||= Rational(interval_factor, octave_denominator)
    end

    def octave_frequency
      @octave_frequency ||= octave_ratio.to_f * base.frequency
    end
  end
end
