module Ceely
  module Scale
    # A Scale is a set of Intervals based on a fundamental Note
    class Base
      attr_reader :fundamental, :size, :offset

      def initialize(fundamental, size, offset=0)
        @fundamental, @size, @offset = fundamental, size, offset
      end

      def notes
        @notes ||= ((0+offset)..(size-1)).collect do |index|
          "Ceely::Interval::#{self.class.name.demodulize}".
            constantize.new(fundamental, index).octave_adjusted_note
        end
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
