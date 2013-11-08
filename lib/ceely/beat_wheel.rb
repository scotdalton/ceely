module Ceely
  class BeatWheel
    BEAT_NOISES = %w{ bass block conga cymbal snare tomtom triangle }

    include Ceely::Mixins::PlayableSet

    attr_reader :ordered_cycles, :cycles

    def initialize(*args)
      super(0.5)
      beat = self.beat
      self << beat << pause << beat << pause << beat << beat
      self << pause << beat << pause << beat << pause << beat
      # Collect a playable for the
      @ordered_cycles = playables.each_index.collect { |index| playables.rotate(index) }
      # Select only cycles that start with a beat
      @ordered_cycles.select! { |cycle| cycle.first.is_a?(Ceely::Beat) }
      raise RuntimeError.new("WTF? There should only be 7 cycles") unless @ordered_cycles.size == 7
      # Play each cycle as a different Beat noises
      @ordered_cycles.each_with_index do |cycle, index|
        beat = self.beat(index)
        cycle.collect! do |playable|
          # If it's a Beat, get the next Beat noise
          (playable.is_a?(Ceely::Beat)) ? beat : playable
        end
      end
      @cycles = @ordered_cycles.collect{ |cycle| cycle}
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

    def play(amplitude, n=1)
      n.times do
        current_cycle.each { |playable| playable.play(amplitude) }
      end
    end
    alias :play_current_cycle :play

    def jam(amplitude, n=1)
      n.times do
        current_cycle.size.times do |index|
          noises = self.noises(index)
          unless(noises.empty?)
            player.play_noises(noises, amplitude)
          else
            current_cycle[index].play(amplitude)
          end
        end
      end
    end

    def noises(index)
      playables = cycles.collect { |cycle| cycle[index] }
      noises = playables.collect do |playable| 
        playable.noise if playable.is_a?(Ceely::Beat)
      end
      noises.compact
    end

    def cycle_to_s(cycle)
      cycle.collect{ |playable| playable.to_s }.join(" ")
    end

    def current_cycle_to_s
      cycle_to_s(current_cycle)
    end

    # Display the playables in the song
    def to_s
      @s ||= cycles.map { |cycle| cycle_to_s(cycle) }.join("\n")
    end
  end
end
