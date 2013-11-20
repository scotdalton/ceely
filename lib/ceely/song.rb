module Ceely
  class Song
    include Ceely::Mixins::PlayableSet
    # Alias the << method from PlayableSet
    alias :note! :<<
    alias :chord! :<<

    attr_reader :key

    def initialize(*args)
      # Default to the even tempered scale
      @key = (args.shift || Ceely::Scales::EvenTempered::Scale.new)
      super(*args)
      @key.duration = tempo
      @key.notes.each { |note| note.duration = tempo }
    end

    def duration
      duration = 0
      playables.each { |playable| duration += playable.duration }
      duration
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

    def chord(*notes)
      Ceely::Chord.new(tempo, *notes)
    end

    def chord_by_names!(*names)
      notes = names.collect { |name| key.note_by_name(name) }
      chord!(chord(*notes))
    end

    def chord_by_types!(*types)
      notes = types.collect { |type| key.note_by_type(type) }
      chord!(chord(*notes))
    end

    def chords!(*chords)
      chords.each { |chord| self << chord }
      self
    end
  end
end