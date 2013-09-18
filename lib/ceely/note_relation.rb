module Ceely
  # A NoteRelation is a Note that takes a fundamental note, a relation number
  # an interval factor
  class NoteRelation < Note
    attr_reader :fundamental, :relation, :interval_factor

    def initialize(fundamental, relation, interval_factor)
      @fundamental, @relation, @interval_factor = fundamental, relation, interval_factor
      super((fundamental.frequency * interval_factor).to_f)
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
      @octave_frequency ||= octave_ratio.to_f * fundamental.frequency
    end
  end
end
