module Ceely
  class Pause
    attr_accessor :duration
    def initialize(duration)
      @duration = duration
    end

    # Play the pause
    def play(*args)
      sleep(duration)
    end
  end
end
