module Ceely
  module Gui
    class Keyboard
      include ShoeElement

      attr_reader :scale, :octaves, :keys

      def initialize(shoes, scale, octaves=1, opts={})
        super(shoes, opts)
        @scale, @octaves = scale, octaves
        @width ||= 800
        @height ||= 400
        @shoe = shoes.stack margin: 0, width: width, height: height do
          shoes.background shoes.darkslategray
          shoes.strokewidth 1
          @keys = scale.sort.each_with_index.collect do |note, index|
            (scale.naturals.include?(note)) ?
              white_key(index, note) : black_key(index, note)
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
            key = keys.find{ |key| key.note.name.eql?(playable.name) }
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

      def white_key(position, note)
        Ceely::Gui::WhiteKey.new(shoes, position, note)
      end

      def black_key(position, note)
        Ceely::Gui::BlackKey.new(shoes, position, note)
      end

    end
  end
end
