module Ceely
  class Noise
    NOISEDIR = "#{File.dirname(__FILE__)}/../../noises"

    include Ceely::Mixins::Playable

    attr_reader :filename

    def initialize(type, duration)
      filename = "#{NOISEDIR}/#{type}.aiff"
      raise NotImplementedError.new("#{filename} doesn't exist") unless File.exist?(filename)
      @filename, @duration = filename, duration
    end

    # Play the noise
    # at the specified amplitude
    def play(amplitude)
      play_noise(self, amplitude)
    end
  end
end
