module Ceely
  require 'java'
  
  class Player
    include_package 'javax.sound.sampled'
    include_package 'java.io'
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

    def play_noise(noise, amplitude)
      open_noise_clip(noise, amplitude, clip)
      clip.start
      clip.drain
      clip.close
    end

    def play_noises(noises, amplitude)
      clips = noises.collect { |tone| new_clip }
      noises.each_with_index do |noise, index|
        open_noise_clip(noise, amplitude, clips[index])
      end
      clips.each { |clip| clip.start }
      clips.each { |clip| clip.drain }
      clips.each { |clip| clip.close }
    end

    # Play the tone
    # at the specified amplitude
    def play_tone(tone, amplitude)
      open_tone_clip(tone, amplitude, clip)
      clip.start
      clip.drain
      clip.close
    end

    # Play the given tones as a chord
    def play_tones(tones, amplitude)
      clips = tones.collect { |tone| new_clip }
      if mixer.synchronization_supported?(clips, true)
        # Synchronize playback
        mixer.synchronize(clips, true)
        # Play the first tone, the others will follow
        tone, clip = tones.first, clips.first
        open_tone_clip(tone, amplitude, clip)
        clip.start()
        clip.drain()
        clip.close()
        mixer.unsynchronize(lines)
      else
        tones.each_with_index do |tone, index|
          open_tone_clip(tone, amplitude, clips[index])
        end
        clips.each { |clip| clip.start }
        clips.each { |clip| clip.drain }
        clips.each { |clip| clip.close }
      end
    end

    def open_noise_clip(noise, amplitude, clip)
      file = java.io.File.new(noise.filename)
      audio_input = AudioSystem.getAudioInputStream(file)
      clip.open(audio_input)
    end

    def open_tone_clip(tone, amplitude, clip)
      # Get the sine wave for the tone at the given amplitude,
      # converted to byte string representations
      # http://ruby-doc.org/core-1.9.3/Array.html#method-i-pack
      sine_wave = sine_wave(tone, amplitude).pack("c*")
      # Unpack the string into Java bytes
      java_bytes = sine_wave.to_java_bytes
      # Open the clip
      clip.open(format, java_bytes, 0, tone.duration*rate)
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

    def clip
      @clip ||= new_clip
    end

    def mixer
      @mixer ||= new_mixer(mixer_info)
    end

    def mixer_info
      @mixer_info ||= mixer_infos.first
    end

    def mixer_infos
      @mixer_infos ||= AudioSystem.get_mixer_info
    end

    def new_clip
      AudioSystem.get_clip(mixer_info)
    end

    def new_mixer(mixer_info)
      AudioSystem.get_mixer(mixer_info)
    end
  end
end
