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
        self << Ceely::Harmony.new(1, c, d)
        pause!(0.5)
        self << Ceely::Harmony.new(1, d, e)
        pause!(0.5)
        self << Ceely::Harmony.new(1, e, f)
        pause!(0.5)
        self << Ceely::Harmony.new(1, f, g)
        pause!(0.5)
        self << Ceely::Harmony.new(1, g, a)
        pause!(0.5)
        self << Ceely::Harmony.new(1, a, b)
        pause!(0.5)
        self << Ceely::Harmony.new(1, b, c)
        pause!(0.5)
      end
    end
  end
end
