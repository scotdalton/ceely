module Ceely
  module SongBook
    class Harmonies4 < Ceely::Song
      attr_reader :flatten
      alias :flatten? :flatten

      def initialize(flatten, *args)
        @flatten = flatten
        super(*args)
        c = scale.note_by_name("C")
        d = scale.note_by_name("D")
        e = scale.note_by_name("E")
        f = scale.note_by_name("F")
        g = scale.note_by_name("G")
        a = scale.note_by_name("A")
        b = scale.note_by_name("B")
        b = b.flatten(Rational(256, 243)) if flatten?
        self << Ceely::Harmony.new(1, c, f)
        pause!(0.5)
        self << Ceely::Harmony.new(1, d, g)
        pause!(0.5)
        self << Ceely::Harmony.new(1, e, a)
        pause!(0.5)
        self << Ceely::Harmony.new(1, f, b)
        pause!(0.5)
        self << Ceely::Harmony.new(1, g, c)
        pause!(0.5)
        self << Ceely::Harmony.new(1, a, d)
        pause!(0.5)
        self << Ceely::Harmony.new(1, b, e)
        pause!(0.5)
      end
    end
  end
end
