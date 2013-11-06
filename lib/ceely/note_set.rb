module Ceely
  class NoteSet
    include Ceely::Mixins::Playable

    attr_reader :notes, :sorted_notes

    def initialize(duration, *notes)
      @duration = duration
      @notes = notes
    end

    def size
      @size ||= notes.size
    end

    def sorted_notes
      @sorted_notes ||= sort
    end

    # Sort the Notes by frequency from low to high
    # Optional size indicates how many to sort
    def sort(size=nil)
      size ||= self.size
      notes.slice(0, size).sort
    end

    # Play the notes in the set
    def play(amplitude, &block)
      play_notes(notes, amplitude, &block)
    end

    # Play the given set of notes
    def play_notes(notes, amplitude, &block)
      notes.each do |note|
        # Set the number of seconds for this note.
        note.duration = duration
        note.play(amplitude) 
        yield if block_given?
      end
    end

    # Display the notes in the scale starting
    # with the fundamental note
    def to_s
      @s ||= (notes.map { |note| "#{note.to_s}" }).join("\n\n")
    end
  end
end