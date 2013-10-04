module Ceely
  # A Scale is a set of Notes based on a fundamental frequency
  class Scale
    attr_reader :fundamental_frequency, :size, :offset, :note_names, :mode_size

    def initialize(fundamental_frequency, size=12, offset=0, note_names=[], mode_size=8)
      @fundamental_frequency = fundamental_frequency
      @size, @offset, @note_names, @mode_size = size, offset, note_names, mode_size
    end

    # Returns an Array of Notes that represents the first mode
    # Doesn't contain the octave.
    def first_mode
      @first_mode ||= sort_notes(mode_size-1)
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

    # Alternate method to return an Array of Notes that represent the Nth mode
    # It doesn't work correctly due to the offset
    def alt_nth_mode(mode_index)
      # Get the index of the starting note
      start_note_index = mode_start_note_index(mode_index)
      # Get which octave we're starting in
      start_octave_index = mode_octave_index(mode_index)
      # Get the starting note in the starting octave and its frequency
      start_note = first_mode[start_note_index].in_octave(start_octave_index)
      start_frequency = start_note.frequency
      # Rotate the note names so the starting note is first
      note_names = self.note_names.rotate(start_note_index)
      # Get a new scale based on the new starting note
      new_scale = self.class.new(start_frequency, size, offset, note_names)
      # Return the new scale's first mode + the start note in the next octave
      new_scale.first_mode << start_note.in_octave(1)
    end

    # The Notes of the Scale, ordered by index
    def notes
      @notes ||= ((0+offset)..(size+offset-1)).collect do |index|
        # Make notes of from the Scale module name
        self.class.name.gsub("Scale", "Note").constantize.
          new(fundamental_frequency, index) 
      end
    end

    # Sort the Notes by frequency from low to high and name them
    # Optional size indicates how many to sort
    def sort_notes(size=nil)
      size ||= self.size
      notes.slice(0, size).sort.each_with_index.collect do |note, index|
        note.name = note_name(index) 
        note
      end
    end

    # Play the notes in the scale from low to high
    def play(seconds, amplitude, &block)
      play_notes(notes.sort, seconds, amplitude, &block)
    end

    # Play the given set of notes
    def play_notes(notes, seconds, amplitude, &block)
      notes.each do |note| 
        note.octave_adjusted_tone.play(seconds, amplitude) 
        yield if block_given?
      end
    end

    # Display the notes in the scale starting
    # with the fundamental note
    def to_s
      @s ||= (notes.map { |note| "#{note.to_s}" }).join("\n\n")
    end

    def note_name(index)
      note_names[index % (mode_size-1)] unless note_names.blank?
    end

    def mode_start_note_index(mode_index)
      mode_index % mode_size
    end
    private :mode_start_note_index

    def mode_octave_index(mode_index)
      (mode_index / mode_size).floor
    end
    private :mode_octave_index
  end
end
