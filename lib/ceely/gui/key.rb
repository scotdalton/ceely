module Ceely
  module Gui
    class Key
      include ShoeElement
      include Comparable

      attr_reader :note, :position, :names
      attr_reader :active_fill, :inactive_fill

      def initialize(shoes, position, note, opts={}, shoe=nil)
        super(shoes, opts)
        @note = note
        @position = position
        @width ||= 50
        @height ||= 350
        @left ||= 50 + (position * width)
        @top ||= 50
        @right = left + width
        @bottom = top + height
        @active_fill = (opts.delete(:active_fill) || shoes.darkgray)
        @inactive_fill = (opts.delete(:inactive_fill) || shoes.white)
        shoe_opts = { left: left, top: top, fill: inactive_fill }.merge(opts)
        @shoe = (shoe || [shoes.rect(left, top, width, height, shoe_opts)])
        key = self
        self.shoe.each { |rect| rect.click { click_action(key) } }
        text_color = opts[:text_color]
        text_left = self.shoe.first.left + (self.shoe.first.width/2 - 7)
        text_top = top - 50
        @names = [ 
          shoes.para(note.name, { left: text_left, top: text_top, stroke: text_color })
        ]
      end

      def click_action(key)
        key.press
        Thread.new { key.play(50) }
        shoes.timer(key.note.duration) { key.release }
      end

      def play(amplitude)
        note.play(amplitude)
      end

      def press
        shoe.each { |rect| rect.style(fill: active_fill, stroke: active_fill) }
      end

      def release
        shoe.each { |rect| rect.style(fill: inactive_fill, stroke: inactive_fill) }
      end

      def <=>(other_key)
        shoe.first.left <=> other_key.shoe.first.left
      end

      def clear
        shoe.each { |rect| rect.unslot }
        shoe.each { |rect| rect.remove }
        names.each { |name| name.remove }
      end
    end

    class WhiteKey < Key
      def initialize(shoes, position, note, accidentals, opts={})
        @accidentals = accidentals
        accidental_height = accidentals.first.height unless accidentals.blank?
        accidental_height ||= 0
        top = (opts[:top] || 50)
        width = 50
        left = (50 + (position * width))
        height = 350
        active_fill = shoes.gray
        inactive_fill = shoes.ivory
        left_accidental = accidental_on_the_left?(position)
        right_accidental = accidental_on_the_right?(position)
        shoe_opts = { fill: inactive_fill, stroke: inactive_fill }
        # Put the bottom rectangle in
        bottom_top = top + accidental_height
        bottom_height = height - accidental_height
        shoe = []
        # If the white key is surrounded by accidentals,
        # shrink it
        if (left_accidental and right_accidental)
          shoe << shoes.rect(left+15, top, width-30, accidental_height, shoe_opts)
        elsif(left_accidental)
          shoe << shoes.rect(left+15, top, width-15, accidental_height, shoe_opts)
        elsif(right_accidental)
          shoe << shoes.rect(left, top, width-15, accidental_height, shoe_opts)
        else
          shoe << shoes.rect(left, top, width, accidental_height, shoe_opts)
        end
        shoe << shoes.rect(left, bottom_top, width, bottom_height, shoe_opts)
        opts = {
          top: top,
          left: left,
          width: width,
          height: height,
          active_fill: active_fill,
          inactive_fill: inactive_fill,
          text_color: shoes.black
        }
        super(shoes, position, note, opts, shoe)
      end

      def accidental_on_the_left?(position)
        @accidentals.any? { |accidental| accidental.position.eql?(position - 1) }
      end

      def accidental_on_the_right?(position)
        @accidentals.any? { |accidental| accidental.position.eql?(position + 1) }
      end
    end

    class BlackKey < Key
      def initialize(shoes, position, note, opts={})
        width = 30
        top = opts[:top]
        opts = {
          left: (50 + (position * 50)),
          top: top,
          width: width,
          height: 250,
          active_fill: shoes.gray,
          inactive_fill: shoes.black,
          text_color: shoes.white
        }
        super(shoes, position, note, opts)
      end
    end
  end
end