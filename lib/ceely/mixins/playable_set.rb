module Ceely
  module Mixins
    module PlayableSet
      attr_accessor :tempo, :playables

      def initialize(*args)
        # Default to 1 beat/second
        @tempo ||= (args.shift || 1)
        @playables = []
      end

      def pause!(factor=1)
        self << Ceely::Pause.new(tempo*factor)
        self
      end

      def <<(playable)
        raise ArgumentError.new("#{playable} is not playable") unless playable.respond_to?(:play)
        @playables << playable
        self
      end

      def play(amplitude, &block)
        @playables.each do |playable|
          playable.play(amplitude)
        end
      end

      # Display the playables in the song
      def to_s
        @s ||= (playables.map { |playable| "#{playable}" }).join("\n\n")
      end
    end
  end
end
