module Ceely
  module Mixins
    module PlayableSet

      include Ceely::Mixins::Playable

      attr_accessor :tempo, :playables

      def initialize(*args)
        # Default to 1 beat/second
        @tempo ||= (args.shift || 1)
        @playables = []
      end

      def pause(factor=1)
        Ceely::Pause.new(tempo*factor)
      end

      def pause!(*args)
        self << pause(*args)
      end

      def <<(playable)
        raise ArgumentError.new("#{playable} is not playable") unless playable.respond_to?(:play)
        @playables << playable
        self
      end

      def play(amplitude)
        @playables.each do |playable|
          playable.play(amplitude)
        end
      end

      # Display the playables in the song
      def to_s
        @s ||= (playables.map { |playable| "#{playable}" }).join(" ")
      end
    end
  end
end
