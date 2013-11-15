module Ceely
  module Gui
    class Key
      include ShoeElement

      attr_reader :note
      attr_reader :active_fill, :inactive_fill

      def initialize(shoes, position, note, opts={})
        super(shoes, opts)
        @note = note
        @width ||= 50
        @height ||= 350
        @left ||= 50 + (position * width)
        @top ||= 50
        @active_fill = (opts.delete(:active_fill) || shoes.gray)
        @inactive_fill = (opts.delete(:inactive_fill) || shoes.white)
        rect_opts = {curve: 10, fill: inactive_fill, stroke: shoes.black}.merge(opts)
        key = self
        @shoe = shoes.rect(left, top, width, height, rect_opts) do
          key.press
          Thread.new { key.play(50) }
          shoes.timer(key.note.duration) { key.release }
        end
      end

      def play(amplitude)
        note.play(amplitude)
      end

      def press
        shoe.style fill: active_fill
      end

      def release
        shoe.style fill: inactive_fill
      end
    end

    class WhiteKey < Key
      def initialize(shoes, position, note)
        opts = {
          width: 50,
          height: 350,
          active_fill: shoes.gradient(shoes.lightgray, shoes.gray),
          inactive_fill: shoes.gradient(shoes.white, shoes.ivory)
        }
        super(shoes, position, note, opts)
      end
    end

    class BlackKey < Key
      def initialize(shoes, position, note)
        opts = {
          width: 50,
          height: 250,
          active_fill: shoes.gradient(shoes.gray, shoes.darkgray),
          inactive_fill: shoes.black
        }
        super(shoes, position, note, opts)
      end
    end
  end
end