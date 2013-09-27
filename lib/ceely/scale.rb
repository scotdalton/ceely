module Ceely
  # A Scale is a set of Notes based on a fundamental frequency
  class Scale
    attr_reader :fundamental_frequency, :size, :offset, :note_names

    def initialize(fundamental_frequency, size=7, offset=0, note_names=[])
      @fundamental_frequency = fundamental_frequency
      @size, @offset, @note_names = size, offset, note_names
    end

    def mode(index, octave)
      fundamental_frequency = notes[index].octave_adjusted_frequency
      fundamental_frequency = fundamental_frequency * 2**octave
      note_names = self.note_names.rotate(index)
      mode = self.class.new(fundamental_frequency, size, offset, note_names)
      # Add the octave, this is a shitty hack.
      mode.notes << self.class.name.gsub("Scale", "Note").constantize.
        new(fundamental_frequency *2, 0, note_names.first)
      return mode
    end

    def note_name(index)
      note_names[index % size] unless note_names.blank?
    end

    # The notes of the scale, ordered by frequency
    def notes
      i = -1
      @notes ||= ((0+offset)..(size+offset-1)).collect { |index|
        # Make notes of from the Scale module name
        self.class.name.gsub("Scale", "Note").constantize.
          new(fundamental_frequency, index) }.sort.collect do |note|
            note.name = note_name(i+=1) 
            note
          end
    end

    # The tones of the scale, ordered by frequency
    def tones
      @tones ||= notes.collect { |note| note.octave_adjusted_tone }
    end

    # Play the notes in the scale starting
    # with the fundamental tone
    def play(seconds, amplitude, &block)
      tones.each do |tone| 
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
