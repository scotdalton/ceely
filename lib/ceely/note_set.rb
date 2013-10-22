module Ceely
  class NoteSet
    attr_reader :notes

    def initialize(*notes)
      @notes = notes
    end

    def size
      @size ||= notes.size
    end

    # Sort the Notes by frequency from low to high
    # Optional size indicates how many to sort
    def sort(size=nil)
      size ||= self.size
      notes.slice(0, size).sort
    end

    # Play the notes in the set
    def play(seconds, amplitude, &block)
      play_notes(notes, seconds, amplitude, &block)
    end

    # Play the given set of notes
    def play_notes(notes, seconds, amplitude, &block)
      notes.each do |note|
        # Set the number of seconds for this tone.
        note.octave_adjusted_tone.duration = seconds
        note.octave_adjusted_tone.play(amplitude) 
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