module Ceely
  require 'java'
  
  class Player
    include_package 'javax.sound.sampled'
    RATE = 1024*32
    SIZE = 8
    CHANNELS = 1
    attr_reader :rate, :size, :channels

    # Constructor for the player takes
    #   - sample rate
    #       the number of samples per second
    #       default: ~32K
    #   - sample size in bits
    #       the number of bits in each sample
    #       default: 8
    #   - number of channels
    #       the number of channels (1 for mono, 2 for stereo, etc.)
    #       default: 1
    def initialize(rate=RATE, size=SIZE, channels=CHANNELS)
      @rate, @size, @channels = rate, size, channels
    end

    # Play the tone for the given number of seconds
    # at the specified amplitude
    def play_tone(tone, amplitude)
      # Play the tone
      play(tone, tone.duration, amplitude, line)
    end

    # Play the given tones as a chord
    def play_tones(tones, amplitude)
      tones.each do |tone|
        # Play the tone
        play(tone, tone.duration, amplitude, new_line)
      end
    end

    def play(tone, seconds, amplitude, line)
      # Open the line
      open_line(line, rate*seconds*100)
      # Get the sine wave for the number of seconds at the given amplitude,
      # converted to byte string representations
      # http://ruby-doc.org/core-1.9.3/Array.html#method-i-pack
      sine_wave = sine_wave(tone, amplitude).pack("c*")
      # Unpack the string into bytes and 
      # play it for the given number of seconds
      # http://www.ruby-doc.org/core-1.9.3/String.html#method-i-unpack
      line.write(sine_wave.unpack('c*'), 0, seconds*rate)
      # Close the line
      close_line(line)
    end

    def open_line(line, buffer)
      # Open the line and start it
      line.open(format, buffer)
      line.start();
    end

    def close_line(a_line)
      # Drain the line and close it
      line.drain();
      line.close();
    end

    # Returns an array of integers, representing the tone's sine wave
    # for the given arguments
    def sine_wave(tone, amplitude)
      wave = []
      0.step(tone.duration, 1.0/rate) do |t|
        wave << Math.sin(t * tone.angular_frequency) * amplitude + 127;
      end
      return wave
    end

    # Method to return the Audio Format encoding
    # Set to PCM unsigned
    # http://en.wikipedia.org/wiki/Pulse-code_modulation
    def encoding
      @encoding ||= AudioFormat::Encoding::PCM_UNSIGNED
    end

    # Method to return the Audio Format
    def format
      @format ||= 
        AudioFormat.new(encoding, rate, size, channels, 1, rate, false)
    end

    # Method to return a source data line
    # for the player's Audio Format
    def line
      @line ||= new_line
    end

    def new_line
      AudioSystem.get_source_data_line(format)
    end
  end
end
