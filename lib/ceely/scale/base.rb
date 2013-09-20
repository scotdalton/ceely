module Ceely
  module Scale
    # A Scale is a set of Note::Relations based on a fundamental Note::Relation
    class Base
      attr_reader :fundamental, :size, :offset

      def initialize(fundamental, size, offset=0)
        @fundamental, @size, @offset = fundamental, size, offset
      end

      def notes
        raise NotImplementedError.new("You should implement notes, Slick.")
      end

      # Play the notes in the scale starting
      # with the fundamental.
      def play(seconds, amplitude)
        notes.each do |note|
          note.play(seconds, amplitude)
        end
      end

      # Display the notes in the scale starting
      # with the fundamental.
      def to_s
        @s ||= (notes.map { |note| "#{note.to_s}" }).join("\n\n")
      end
    end
  end
end
