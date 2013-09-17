module Ceely
  require 'java'
  # Module containing all Sampled functionality.
  module Sampled
    
    class Player
      include_package 'javax.sound.sampled'
      RATE = 1024*32
      SIZE = 8
      CHANNELS = 1
      attr_reader :rate, :size, :channels
      
      def initialize(rate=RATE, size=SIZE, channels=CHANNELS)
        @rate, @size, @channels = rate, size, channels
      end
      
      def format
        @format ||= AudioFormat.new(rate, size, channels, false, false)
      end

      def line
        @line ||= AudioSystem.get_source_data_line(format)
      end

      def play(note, seconds)
        line.open(format, rate)
        line.start();
        play_note(note, seconds);
        line.drain();
        line.close();
      end

      def play_note(note, seconds, amplitude=50)
        frequency = 2.0*Math::PI*note.frequency
        wave = []
        0.step(seconds, 1.0/rate) do |t|
          y = Math.sin(t * frequency) * amplitude + 127;
          wave << y.to_i.chr
        end
        line.write(wave.join.unpack('c*'), 0, seconds*10000)
      end
    end
  end
end
