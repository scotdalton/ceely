module Ceely
  # A Scale is a set of Notes based on a fundamental frequency
  class Scale
    attr_reader :fundamental_frequency, :size, :offset, :note_names, :mode_size

    def initialize(fundamental_frequency, size=12, offset=0, note_names=[], mode_size=8)
      @fundamental_frequency = fundamental_frequency
      @size, @offset, @note_names, @mode_size = size, offset, note_names, mode_size
    end

    # Return the first mode
    # A mode is an array of note
    def first_mode
      @first_mode ||= sorted_notes(mode_size-1)
    end

    def nth_mode(mode_index)
      shift_factor = mode_index % mode_size
      octave_factor = (mode_index / mode_size).floor
      # Get a local copy of the mode
      mode_start = first_mode.collect { |note| note.in_octave(octave_factor) }
      mode_end = mode_start.shift(shift_factor).collect { |note| note.in_octave(1) }
      mode = (mode_start + mode_end) 
      # Add the octave
      mode << mode.first.in_octave(1)
    end

    def note_name(index)
      note_names[index % (mode_size-1)] unless note_names.blank?
    end

    # The notes of the scale, ordered by frequency
    def notes
      @notes ||= ((0+offset)..(size+offset-1)).collect do |index|
        # Make notes of from the Scale module name
        self.class.name.gsub("Scale", "Note").constantize.
          new(fundamental_frequency, index) 
      end
    end

    def sorted_notes(size=nil)
      # This looks disgusting
      i = -1
      size ||= self.size
      notes.slice(0, size).sort.collect do |note|
        note.name = note_name(i+=1) 
        note
      end
    end

    # Play the notes in the scale starting
    # with the fundamental tone
    def play(seconds, amplitude, &block)
      play_notes(notes, seconds, amplitude, &block)
    end

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
  end
end
