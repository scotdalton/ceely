module Ceely
  class Pause
    include Ceely::Mixins::Playable

    def initialize(duration)
      @duration = duration
    end
  end
end
