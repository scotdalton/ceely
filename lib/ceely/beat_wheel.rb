module Ceely
  class BeatWheel
    BEAT_NOISES = %w{ bass block conga cymbal snare tomtom triangle }

    include Ceely::Mixins::PlayableSet

    attr_reader :cycles

    def initialize(*args)
      super(0.5)
      beat = self.beat
      self << beat << pause << beat << pause << beat << beat
      self << pause << beat << pause << beat << pause << beat
      # Collect a playable for the
      @cycles = playables.each_index.collect { |index| playables.rotate(index) }
      # Select only cycles that start with a beat
      @cycles.select! { |cycle| cycle.first.is_a?(Ceely::Beat) }
      raise RuntimeError.new("WTF? There should only be 7 cycles") unless @cycles.size == 7
      # Play each cycle as a different Beat noises
      @cycles.each_with_index do |cycle, index|
        beat = self.beat(index)
        cycle.collect! do |playable|
          # If it's a Beat, get the next Beat noise
          (playable.is_a?(Ceely::Beat)) ? beat : playable
        end
      end
    end

    # Rotates the wheel and returns self.
    # Suitable for chaining
    def rotate!(count = 1)
      cycles.rotate!(count)
      self
    end

    def beat(index=0)
      "Ceely::Beats::#{BEAT_NOISES[index].capitalize}".constantize.new(tempo)
    end

    def current_cycle
      cycles.first
    end

    def play(amplitude)
      current_cycle.each { |playable| playable.play(amplitude) }
    end

    def loop(n, amplitude)
      n.times { play(amplitude) }
    end

    # Display the playables in the song
    def to_s
      @s ||= cycles.map { |cycle| cycle.map { |playable| "#{playable}" }.join(" ") }.join("\n")
    end
  end
end
