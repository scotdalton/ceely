module Ceely
  # A HarmonicNote is a NoteRelation with the interval factor equal to the relation number
  class HarmonicNote < NoteRelation
    alias :degree :relation

    def initialize(fundamental, relation)
      interval_factor = Rational(relation, 1)
      super(fundamental, relation, interval_factor)
    end

    def octave
      @octave ||= Math.log2(relation).to_i + 1
    end

    def octave_denominator
      @octave_denominator ||= 2**(octave - 1)
    end
  end
end
