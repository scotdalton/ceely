module Ceely
  module Mixins
    module Modes
      # Returns an Array that represents the first mode
      # Doesn't contain the octave.
      def first_mode
        @first_mode ||= naturals
      end

      # Returns an Array that represent the Nth mode
      def nth_mode(mode_index)
        # Get the index of the starting object
        start_index = mode_index % (size+1)
        # Get the octave we're starting in
        octave_index = (mode_index / (size+1)).floor
        # Get a copy of the mode in the starting octave
        head = first_mode.collect { |note| note.in_octave(octave_index) }
        # Take off everything before the start note and increase it an octave
        # This will be the mode's tail
        tail = head.shift(start_index).collect { |note| note.in_octave(1) }
        # Pin the tail on the head
        mode = (head + tail) 
        # Add the octave of the first note to the end
        mode << mode.first.in_octave(1)
      end
    end
  end
end
