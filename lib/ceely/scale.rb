module Ceely
  # A Scale is a NoteSet with Notes based on a fundamental frequency
  # and some note names and note types
  class Scale < Ceely::NoteSet
    NATURALS = %w{ 1 2 M3 4 5 M6 M7 }

    include Ceely::Mixins::Modes
    include Ceely::Mixins::CircleOfFifths

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
      @notes.each { |note| note.duration = duration }
    end

    # Make notes from the module name
    def new_note(index)
      name = self.class.name.deconstantize + "::Note"
      name.constantize.new(fundamental_frequency, index)
    end

    def note_by_index(index)
      return @notes[index] unless @notes.blank? or @notes[index].blank?
      new_note(index)
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

    # Play the notes in the scale from low to high
    def play(amplitude, &block)
      play_notes(notes.sort, amplitude, &block)
    end
  end
end
