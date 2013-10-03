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

    def ith_mode(index)
      # Get a local copy of the mode
      mode_start = first_mode.collect { |note| note }
      mode_end = mode_start.shift(index).collect { |note| note.in_octave(1) }
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
        self.class.name.gsub("Scale", "Note").constantize.new(fundamental_frequency, index) 
      end
    end

    def sorted_notes(size)
      # This looks disgusting
      i = -1
      size ||= self.size
      notes.slice(0, size).sort.collect do |note|
        note.name = note_name(i+=1) 
        note
      end
    end

    # The tones of the scale
    def tones
      @tones ||= notes.collect { |note| note.octave_adjusted_tone }
    end

    # The tones of the ith mode
    def ith_mode_tones(index)
      ith_mode(index).collect { |note| note.octave_adjusted_tone }
    end

    # Play the notes in the scale starting
    # with the fundamental tone
    def play(seconds, amplitude, &block)
      tones.each do |tone| 
        tone.play(seconds, amplitude) 
        yield if block_given?
      end
    end

    # Play the notes in the scale starting
    # with the fundamental tone
    def play_ith_mode(index, seconds, amplitude, &block)
      ith_mode_tones(index).each do |tone| 
        tone.play(seconds, amplitude) 
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
