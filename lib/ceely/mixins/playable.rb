module Ceely
  module Mixins
    module Playable
      attr_accessor :duration

      # By default, playables just sleep
      def play(*args)
        sleep(duration)
      end

      # Play the given tone at the given 
      # at the specified amplitude
      def play_tone(tone, amplitude)
        player.play_tone(tone, amplitude)
      end

      # Play the given noise at the given 
      # at the specified amplitude
      def play_noise(noise, amplitude)
        player.play_noise(noise, amplitude)
      end

      # New player with default settings
      def player
        @player ||= Player.new
      end
    end
  end
end
