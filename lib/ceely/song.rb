module Ceely
  class Song
    attr_reader :key, :tempo, :playables

    def initialize(key, tempo)
      @key, @tempo = key, tempo
      @playables = []
    end

    def note_by_name!(name)
      note!(key.note_by_name(name))
    end

    def note_by_type!(type)
      note!(key.note_by_type(type))
    end

    def notes_by_name!(*names)
      names.each { |name| note_by_name!(name) }
      self
    end

    def notes_by_type!(*types)
      types.each { |type| note_by_type!(type) }
      self
    end

    def notes!(*notes)
      notes.each { |note| self << note }
      self
    end

    def chord_by_names!(*names)
      notes = names.collect { |name| key.note_by_name(name) }
      chord!(Ceely::Chord.new(tempo, *notes))
    end

    def chord_by_types!(*types)
      notes = types.collect { |type| key.note_by_type(type) }
      chord!(Ceely::Chord.new(tempo, *notes))
    end

    def chords!(*chords)
      chords.each { |chord| self << chord }
      self
    end

    def <<(playable)
      raise ArgumentError.new("#{playable} is not playable") unless playable.respond_to?(:play)
      @playables << playable
      self
    end
    alias :note! :<<
    alias :chord! :<<

    def play(amplitude, &block)
      @playables.each do |playable|
        playable.play(amplitude)
        yield if block_given?
      end
    end

    # Display the playables in the song
    def to_s
      @s ||= (playables.map { |playable| "#{playable}" }).join("\n\n")
    end
  end
end