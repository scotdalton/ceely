module Ceely
  # A Scale is a NoteSet with Notes based on a fundamental frequency
  # and some note names and note types
  class Scale < Ceely::NoteSet
    NATURALS = %w{ 1 2 M3 4 5 M6 M7 }

    attr_reader :fundamental_frequency, :size, :offset, :range
    attr_reader :note_names, :note_types

    def initialize(fundamental_frequency, *args)
      @fundamental_frequency = fundamental_frequency
      @size = (args.shift || 12)
      @offset = (args.shift || 0)
      @note_names = (args.shift || [])
      # TODO: Raise an argument error if the note names don't match the size
      # unless of course they're empty, cuz that's OK
      @note_types = (args.shift || [])
      # TODO: Raise an argument error if the interval type don't match the size
      # unless of course they're empty, cuz that's OK
      @duration = (args.shift || 0.5)
      @range = (0+offset)..(size+offset-1)
      @notes ||= range.collect { |index| note_by_index(index) }
    end

    def note_by_index(index)
      return @notes[index] unless @notes.blank? or @notes[index].blank?
      # Make notes of from the module name
      name = self.class.name
      name.gsub!(name.demodulize, "Note")
      name.constantize.new(fundamental_frequency, index)
    end

    def note_by_name(name)
      sorted_notes.find { |note| note.name.eql? name }
    end

    def note_by_type(type)
      sorted_notes.find { |note| note.type.eql? type }
    end

    def note_name(index)
      note_names[index % size] unless note_names.blank?
    end

    def note_type(index)
      note_types[index % size] unless note_types.blank?
    end

    # Sort the Notes by frequency from low to high AND NAME THEM
    def sort(size=nil)
      super(size).each_with_index.collect do |note, index|
        note.name = note_name(index) 
        note.type = note_type(index) 
        note
      end
    end

    def naturals
      @naturals ||= NATURALS.collect { |type| note_by_type(type) }
    end

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

    # Play the notes in the scale from low to high
    def play(amplitude, &block)
      play_notes(notes.sort, amplitude, &block)
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

    # Returns an Array of Notes that represents the first mode
    # Doesn't contain the octave.
    def first_mode
      @first_mode ||= naturals
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
