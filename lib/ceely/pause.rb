module Ceely
  class Pause
    include Ceely::Playable

    def initialize(duration)
      @duration = duration
    end
  end
end
