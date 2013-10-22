module Ceely
  # A Scale is a NoteSet with Notes based on a fundamental frequency
  # and some note names and a mode size
  class Scale < Ceely::NoteSet
    attr_reader :fundamental_frequency, :size, :offset, :note_names

    def initialize(fundamental_frequency, size=12, offset=0, note_names=[])
      # TODO: Raise an argument error if the note names don't match the size
      # unless of course they're empty, cuz that's OK
      @fundamental_frequency = fundamental_frequency
      @size, @offset, @note_names = size, offset, note_names
      @notes ||= ((0+offset)..(size+offset-1)).collect do |index|
        name = self.class.name
        # Make notes of from the module name
        name.gsub(name.demodulize, "Note").constantize.
          new(fundamental_frequency, index)
      end
    end

    def circle_of_fifths
      return @circle_of_fifth if defined? @circle_of_fifths
      @circle_of_fifths = []
      sorted_notes = self.sort
      # Start at the beginning
      @circle_of_fifths << sorted_notes.first
      (1..(sorted_notes.size-1)).step do
        @circle_of_fifths << sorted_notes.rotate!(7).first
      end
      @circle_of_fifths
    end

    # Play the notes in the scale from low to high
    def play(seconds, amplitude, &block)
      play_notes(notes.sort, seconds, amplitude, &block)
    end

    # Sort the Notes by frequency from low to high AND NAME THEM
    def sort(size=nil)
      super(size).each_with_index.collect do |note, index|
        note.name = note_name(index) 
        note
      end
    end

    # Returns an Array of Notes that represents the first mode
    # Doesn't contain the octave.
    def first_mode
      @first_mode ||= sort
    end

    # Returns an Array of Notes that represent the Nth mode
    def nth_mode(mode_index)
      # Get the index of the starting note
      start_note_index = mode_start_note_index(mode_index)
      # Get which octave we're starting in
      start_octave_index = mode_octave_index(mode_index)
      # Get a copy of the mode in the starting octave
      mode_head = 
        first_mode.collect { |note| note.in_octave(start_octave_index) }
      # Take off everything before the start note and increase it an octave
      # This will be the mode's tail
      mode_tail = 
        mode_head.shift(start_note_index).collect { |note| note.in_octave(1) }
      # Pin the tail on the head
      mode = (mode_head + mode_tail) 
      # Add the octave of the first note to the end
      mode << mode.first.in_octave(1)
    end

    def note_name(index)
      note_names[index % size] unless note_names.blank?
    end

    def mode_start_note_index(mode_index)
      mode_index % (size+1)
    end
    private :mode_start_note_index

    def mode_octave_index(mode_index)
      (mode_index / (size+1)).floor
    end
    private :mode_octave_index
  end
end
