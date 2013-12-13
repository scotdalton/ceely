module Ceely
  module Gui
    # A game can be in a pre state, a ready state, a playing state, a listening state or a judging state
    # In the pregame state we wait for the user to initiate the game
    # In the ready state, we play the selected scale and then confirm that the player is ready
    # In the playing state, we play a random song
    # In the listening state, we capture the notes played
    # In the judging state, we match the captured notes against what we already have
    class Game
      SCALES = %w{ Meantone Rameau Zarlino Pythagorean Dodecaphonic Ptolemaic EvenTempered }
      include ShoeElement

      attr_reader :level, :state, :scale, :successful_runs

      def initialize(shoes, opts={})
        super(shoes, opts)
        @score = 0
        @instruction_flow = shoes.flow margin: 10 do
          shoes.flow  do
            shoes.title "How Good Is Your Ear?", { align: "center" }
          end
          shoes.flow do
            @level_para = shoes.subtitle ""
            @score_para = shoes.subtitle "", { left: 925 }
            @state_oval = shoes.oval({ fill: shoes.blue, radius: 10, left: 905, top: 55 })
          end
          shoes.flow width: 1050, height: 80, margin: 10 do
            shoes.background shoes.gray
            shoes.border shoes.darkslategray
            shoes.para "This game plays a random sequence of notes and asks you to identify them on the keyboard."
            shoes.para "You get 10 points per correct response."
            shoes.para "As you advance the sequences get longer and there is less help. Also beats can join the party."
            shoes.para "Choose a scale and click 'Play' to hear the sequence. When the blue dot goes green, it's your time to shine."
          end
        end
        # Set the scales
        @control_flow = shoes.flow margin: 10 do
          shoes.flow do
            shoes.para "Choose a scale: "
            @scales = shoes.list_box(items: SCALES) { refresh_keyboard }
            @play_scale = Ceely::Gui::LabeledCheck.new(shoes, "Play the scale before you start?")
          end
          shoes.flow({width: 300}) do
            @play = shoes.button("Play") { ready }
            @quit = shoes.button("Quit") { quit }
          end
        end
        @keyboard_flow = shoes.flow {}
        pregame
      end

      def valid_scale?
        @scales.text.present? unless @scales.blank?
      end

      def scale
        if valid_scale?
          @scale ||= "Ceely::Scales::#{@scales.text}::Scale".safe_constantize.new
        end
      end

      def beat_wheel
        @beat_wheel ||= Ceely::BeatWheel.new(1)
      end

      def keyboard
        return @keyboard unless @keyboard.blank?
        p level.name
        @keyboard = Ceely::Gui::Keyboard.new(shoes, scale, 2,
          { width: width, top: 180, left: 20, height: 465, 
            show_names: level.show_names?, press_keys: level.press_keys? })
        @keyboard.click_callback = -> { judge }
        @keyboard
      end

      def remove_keyboard
        @keyboard_flow.clear
        @keyboard.clear unless @keyboard.blank?
        @keyboard = nil
        @scale = nil
        @scale_song = nil
      end

      def refresh_keyboard
        remove_keyboard
        shoes.timer(0) { @keyboard_flow.append{ keyboard } } if valid_scale?
      end

      def refresh_score
        shoes.timer(0) { @score_para.replace("Score: #{@score}") }
      end

      def refresh_state
        color = (listening?) ? shoes.green : shoes.blue
        shoes.timer(0) { @state_oval.fill = color }
      end

      def scale_song
        @scale_song ||= Ceely::SongBook::ScaleOctaves.new(scale, 0.5, 2) if scale.present?
      end

      def play_scale_song
        keyboard.play_song(scale_song, 50) if scale_song.present?
      end

      def random_song
        @random_song ||= Ceely::RandomSongGenerator.new(scale, 0.5, level.song_size).song
      end

      def play_random_song
        keyboard.play_song(random_song, 50) if random_song.present?
      end

      def disable
        shoes.timer(0) do 
          @scales.state = "disabled"
          @play.state = "disabled"
        end
      end

      def enable
        @state = :pre
        shoes.timer(0) do 
          @scales.state = nil
          @play.state = nil
        end
      end

      def set_level
        @level = case
        when @score < 10
          Noob.new
        when @score < 50
          Beginner.new
        when @score < 100
          BeginnerPlus.new
        when @score < 150
          Intermediate.new
        when @score < 200
          IntermediatePlus.new
        when @score < 250
          Advanced.new
        when @score < 300
          AdvancedPlus.new
        else
          Pro.new
        end
        shoes.timer(0) { @level_para.replace("Level: #{level.name}") }
      end

      def pregame
        @state = :pregame
        @random_song = nil
        refresh_state
        refresh_score
        set_level
        refresh_keyboard
        enable
      end

      def ready
        @state = :ready
        unless valid_scale? 
          shoes.timer(0) { shoes.alert("Please select a scale in order to start.") }
          return false
        end
        disable
        if @play_scale.checked?
          play_scale_song
          shoes.timer(scale_song.duration + (scale_song.playables.size * 0.1) + 0.5) do
            if shoes.confirm("Ready to test your ear?")
              play
            else
              enable
            end
          end
        else
          play
        end
      end

      def play
        @state = :play
        beats_thread = Thread.new { beat_wheel.rotate!(5).jam(5, 50) } if beats?
        play_random_song
        shoes.timer(random_song.duration + (random_song.playables.size * 0.1) + 0.1) do
          beats_thread.kill if beats_thread.present?
          listen
        end
      end

      # If the level has beats, you're 1/2 to get them
      def beats?
        return false unless level.beats?
        prng = Random.new(Time.now.to_i)
        rand = prng.rand(2)
        return rand == 0
      end

      def listen
        @state = :listen
        refresh_state
        keyboard.record = true
      end

      def listening?
        @state.eql? :listen
      end

      def judge
        return unless state.eql?(:listen)
        return unless keyboard.recorded_notes.size >= random_song.playables.size
        @state = :judge
        refresh_state
        keyboard.record = false
        if keyboard.recorded_notes == random_song.playables
          @score += 10
        else
          shoes.timer(0) { shoes.alert("Better luck next time!") }
        end
        pregame
      end

      def quit
        exit
      end

      class Level
        attr_reader :name, :song_size
        attr_reader :show_names, :press_keys, :beats, :random_scale
        alias :show_names? :show_names
        alias :press_keys? :press_keys
        alias :beats? :beats
        alias :random_scale? :random_scale

        # Usage:
        #   Level.new("Beginner", 3, true, true, false, false)
        #   Level.new("Beginner plus", 5, true, true, false, false)
        #   Level.new("Intermediate", 5, false, true, false, false)
        #   Level.new("Intermediate plus", 7, false, true, false, false)
        #   Level.new("Advanced", 7, false, false, false, false)
        #   Level.new("Advanced plus", 7, false, false, true, false)
        #   Level.new("Pro", 9, false, false, true, true)
        def initialize(*args)
          @name = args.shift
          @song_size = args.shift
          @show_names = args.shift
          @press_keys = args.shift
          @beats = args.shift
          @random_scale = args.shift
        end
      end

      class Noob < Level
        def initialize
          super("Noob", 3, true, true, false, false)
        end
      end

      class Beginner < Level
        def initialize
          super("Beginner", 5, true, true, false, false)
        end
      end

      class BeginnerPlus < Level
        def initialize
          super("Beginner Plus", 5, true, true, true, false)
        end
      end

      class Intermediate < Level
        def initialize
          super("Intermediate", 5, false, true, false, false)
        end
      end

      class IntermediatePlus < Level
        def initialize
          super("Intermediate Plus", 5, false, true, true, false)
        end
      end

      class Advanced < Level
        def initialize
          super("Advanced", 7, false, false, false, false)
        end
      end

      class AdvancedPlus < Level
        def initialize
          super("Advanced Plus", 7, false, false, true, false)
        end
      end

      class Pro < Level
        def initialize
          super("Professional", 9, false, false, true, true)
        end
      end
    end
  end
end