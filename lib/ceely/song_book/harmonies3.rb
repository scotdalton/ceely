module Ceely
  module SongBook
    class Harmonies3 < Ceely::Song
      
      def initialize(flatten, *args)
        super(*args)
        c = key.note_by_name("C")
        d = key.note_by_name("D")
        e = key.note_by_name("E")
        f = key.note_by_name("F")
        g = key.note_by_name("G")
        a = key.note_by_name("A")
        b = key.note_by_name("B")
        self << Ceely::Harmony.new(1, c, e)
        pause!(0.5)
        self << Ceely::Harmony.new(1, d, f)
        pause!(0.5)
        self << Ceely::Harmony.new(1, e, g)
        pause!(0.5)
        self << Ceely::Harmony.new(1, f, a)
        pause!(0.5)
        self << Ceely::Harmony.new(1, g, b)
        pause!(0.5)
        self << Ceely::Harmony.new(1, a, c)
        pause!(0.5)
        self << Ceely::Harmony.new(1, b, d)
        pause!(0.5)
      end
    end
  end
end
