module Ceely
  module Mixins
    module CircleOfFifths

      def circle_of_fifths
        return @circle_of_fifths if defined? @circle_of_fifths
        @circle_of_fifths = []
        # Start at the beginning
        @circle_of_fifths << sorted_notes.first
        (1..(sorted_notes.size-1)).step do
          @circle_of_fifths << sorted_notes.rotate!(7).first
        end
        @circle_of_fifths
      end

      def circle_of_fifths_in_octave(octave)
        circle_of_fifths.collect { |note| note.in_octave(octave) }
      end

      # Play the circle of fifths
      def play_circle_of_fifths(amplitude, &block)
        play_circle_of_fifths_in_octave(0, amplitude, &block)
      end

      # Play a slice of the circle of fifths
      def play_circle_of_fifths_slice(slice, amplitude, &block)
        play_circle_of_fifths_slice_in_octave(slice, 0, amplitude, &block)
      end

      # Play the circle of fifths in the given octave
      def play_circle_of_fifths_in_octave(octave, amplitude, &block)
        play_circle_of_fifths_slice_in_octave(nil, octave, amplitude, &block)
      end

      # Play the circle of fifths slice in the given octave
      def play_circle_of_fifths_slice_in_octave(slice, octave, amplitude, &block)
        notes = circle_of_fifths_in_octave(octave)
        notes = notes.slice(slice) unless slice.blank?
        play_notes(notes, amplitude, &block)
      end
    end
  end
end
