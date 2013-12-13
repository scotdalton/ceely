module Ceely
  module SongBook
    class Harmonies5 < Ceely::Song
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
        self << Ceely::Harmony.new(1, c, g)
        pause!(0.5)
        self << Ceely::Harmony.new(1, d, a)
        pause!(0.5)
        self << Ceely::Harmony.new(1, e, b)
        pause!(0.5)
        self << Ceely::Harmony.new(1, f, c)
        pause!(0.5)
        self << Ceely::Harmony.new(1, g, d)
        pause!(0.5)
        self << Ceely::Harmony.new(1, a, e)
        pause!(0.5)
        self << Ceely::Harmony.new(1, b, f)
        pause!(0.5)
      end
    end
  end
end
