module Ceely
  class Beat
    include Ceely::Mixins::Playable

    # A Beat takes its noise from its name
    # Duration doesn't do much at the moment
    def initialize(duration)
      @duration = duration
    end

    def play(amplitude)
      noise.play(amplitude)
    end

    def noise
      @noise ||= Ceely::Noise.new(self.class.name.demodulize.downcase, duration)
    end
  end
end
