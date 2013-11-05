module Ceely
  module Playable
    attr_accessor :duration

    # By default, playables just sleep
    def play(*args)
      sleep(duration)
    end

    # New player with default settings
    def player
      @player ||= Player.new
    end
  end
end