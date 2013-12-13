module Ceely
  module Gui
    class Keyboard
      include ShoeElement
      attr_reader :scale, :octaves, :keys
      attr_reader :show_names, :press_keys
      alias :show_names? :show_names
      alias :press_keys? :press_keys
      attr_reader :record, :recorded_notes
      alias :record? :record
      attr_accessor :click_callback

      def initialize(shoes, scale, octaves=1, opts={})
        super(shoes, opts)
        @scale, @octaves = scale, octaves
        @width ||= 800
        @height ||= 500
        @top ||= 50
        # Show names by default
        @show_names = opts.delete(:show_names)
        @show_names ||= true
        # Press keys by default
        @press_keys = opts.delete(:press_keys)
        @press_keys ||= true
        @keys = []
        @shoe = shoes.stack margin: 0, width: width, height: height do
          shoes.background shoes.darkslategray
          shoes.strokewidth 1
          notes = scale.sorted_notes
          octaves.times do |octave|
            # Draw the accidentals first
            @accidental_keys = notes.each_with_index.collect { |note, index|
              octave_index = index + (octave * keys.size)
              accidental_key(octave_index, note.in_octave(octave)) unless scale.naturals.include?(note)
            }.compact
            # Draw the naturals last
            @natural_keys = notes.each_with_index.collect { |note, index|
              octave_index = index + (octave * keys.size)
              natural_key(octave_index, note.in_octave(octave)) if scale.naturals.include?(note)
            }.compact
            # Keys are the naturals and the accidentals
            @keys += @natural_keys + @accidental_keys
          end
        end
        @keys.sort!
        @keys.each_with_index do |key, index|
          # Natural C is first so don't do anything
          next if index.eql? 0
          # Get the previous "right"
          previous_right = @keys[index-1].shoe.first.right
          # and the current "left"
          current_left = key.shoe.first.left
          # and their difference
          delta = current_left - previous_right
          # then shift every element over
          # by the delta
          key.shoe.each { |element| element.left = element.left - delta + 1 }
          # and shift their names
          key.names.each { |name| name.left = name.left - delta + 1 }
        end
        @keypress = shoes.keypress do |letter|
          key = @keys.find { |key| key.letter.eql?(letter.to_s) }
          key.click_action(key) if key
        end
        @record = false
        @recorded_notes = []
      end

      def record=(record)
        if record == true
          @recorded_notes = []
          @recorded_song = nil
          @record = true
        else
          @record = false
        end
      end

      def recorded_song
        @recorded_song ||=
          Ceely::Song.new(scale, scale.duration).notes! *recorded_notes
      end

      def playback(amplitude)
        play_song(recorded_song, amplitude)
      end

      def play_song(song, amplitude)
        unless scale.instance_of?(song.scale.class)
          raise ArgumentError.new("You need a different keyboard!")
        end
        start = 0.1
        song.playables.each do |playable|
          # Inactivate after the playable has played
          stop = start + playable.duration
          if playable.is_a?(Ceely::Note)
            key = keys.find do |key| 
              key.note.name.eql?(playable.name) and 
                key.note.octave.eql?(playable.octave)
            end
            shoes.timer(start) do
              key.press if press_keys?
              p key.letter
              Thread.new { playable.play(amplitude) }
            end
            shoes.timer(stop) { key.release } if press_keys?
          elsif playable.is_a?(Ceely::Pause)
            shoes.timer(start) { playable.play(amplitude) }
          elsif playable.is_a?(Ceely::Chord)
            playable.notes.each do |note|
              key = keys.find{ |key| key.note.name.eql?(playable.name) }
              shoes.timer(start) do
                key.press if press_keys?
                Thread.new { note.play(amplitude) }
              end
              shoes.timer(stop) { key.release } if press_keys?
            end
          end
          start = stop + 0.1
        end
      end

      def clear
        keys.each { |key| key.clear }
        shoe.clear
        @keypress.clear
      end

      def key_callback(key)
        # Record the pressed note
        recorded_notes << key.note
        # Callback on click
        click_callback.call if click_callback.respond_to? :call
      end

      def natural_key(position, note)
        key = Ceely::Gui::WhiteKey.new(shoes, position, note, @accidental_keys, 
          { top: top + 100, show_names: show_names })
        key.click_callback = -> { key_callback(key) }
        key
      end

      def accidental_key(position, note)
        key = Ceely::Gui::BlackKey.new(shoes, position, note, 
          { top: top + 100, show_names: show_names })
          key.click_callback = -> { key_callback(key) }
        key
      end
    end
  end
end
