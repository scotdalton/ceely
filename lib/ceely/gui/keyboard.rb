module Ceely
  module Gui
    class Keyboard
      include ShoeElement

      attr_reader :scale, :octaves, :keys

      def initialize(shoes, scale, octaves=1, opts={})
        super(shoes, opts)
        @scale, @octaves = scale, octaves
        @width ||= 800
        @height ||= 500
        @shoe = shoes.stack margin: 0, width: width, height: height do
          shoes.background shoes.darkslategray
          shoes.strokewidth 1
          notes = scale.sorted_notes
          @keys = []
          octaves.times do |octave|
            # Draw the accidentals first
            @accidental_keys = notes.each_with_index.collect { |note, index|
              octave_index = index + (octave * keys.size)
              p octave_index 
              accidental_key(octave_index, note.in_octave(octave)) unless scale.naturals.include?(note)
            }.compact
            @natural_keys = notes.each_with_index.collect { |note, index|
              octave_index = index + (octave * keys.size)
              natural_key(octave_index, note.in_octave(octave)) if scale.naturals.include?(note)
            }.compact
            @keys += @natural_keys + @accidental_keys
            end
          end
          @keys.sort!
          @keys.each_with_index do |key, index|
            next if index.eql? 0
            # Get the previous "right"
            previous_right = @keys[index-1].shoe.first.right
            # and the current "left"
            current_left = key.shoe.first.left
            # and their difference
            delta = current_left - previous_right
            key.shoe.each do |element|
              # Shift every element over
              new_left = element.left - delta + 1
              element.left = new_left
            end
            key.names.each do |name|
              # Shift every name over
              new_left = name.left - delta + 1
              name.left = new_left
            end
        end
      end

      def play_song(song, amplitude)
        raise ArgumentError.new("You need a different keyboard!") unless scale.instance_of?(song.key.class)
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
              key.press
              Thread.new { playable.play(amplitude) }
            end
            shoes.timer(stop) { key.release }
          elsif playable.is_a?(Ceely::Pause)
            shoes.timer(start) { playable.play(amplitude) }
          elsif playable.is_a?(Ceely::Chord)
            playable.notes.each do |note|
              key = keys.find{ |key| key.note.name.eql?(playable.name) }
              shoes.timer(start) do
                key.press
                Thread.new { note.play(amplitude) }
              end
              shoes.timer(stop) { key.release }
            end
          end
          start = stop + 0.1
        end
      end

      def natural_key(position, note)
        Ceely::Gui::WhiteKey.new(shoes, position, note, @accidental_keys)
      end

      def accidental_key(position, note)
        Ceely::Gui::BlackKey.new(shoes, position, note)
      end
    end
  end
end
