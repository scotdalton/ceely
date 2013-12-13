module Ceely
  module Gui
    class Key
      include ShoeElement
      include Comparable
      attr_reader :note, :position, :names
      attr_reader :active_fill, :inactive_fill
      attr_reader :show_names
      alias :show_names? :show_names
      attr_accessor :click_callback

      def initialize(shoes, position, note, opts={}, shoe=nil)
        super(shoes, opts)
        @note = note
        @position = position
        @width ||= 50
        @height ||= 350
        @left ||= 50 + (position * width)
        @top ||= 50
        # Show names by default
        @show_names = opts.delete(:show_names)
        @show_names ||= true
        @active_fill = (opts.delete(:active_fill) || shoes.darkgray)
        @inactive_fill = (opts.delete(:inactive_fill) || shoes.white)
        shoe_opts = { left: left, top: top, fill: inactive_fill }.merge(opts)
        @shoe = (shoe || [shoes.rect(left, top, width, height, shoe_opts)])
        key = self
        self.shoe.each { |rect| rect.click { click_action(key) } }
        @names = []
        if show_names?
          first_rect = self.shoe.first
          text_color = opts[:text_color]
          text_left = first_rect.left + (first_rect.width/2 - 5)
          text_top = top - 190
          @names << shoes.para(note.name, { left: text_left, top: text_top,
            stroke: text_color })
        end
      end

      def letter
        return @letter if defined? @letter
        # The next octave is signified by alt_
        @letter = (note.octave.eql? 1) ? "alt_" : ""
        if(note.name.match('#'))
          # Sharps are upper case, e.g. C plays C#
          @letter += note.name.gsub('#', '')
        elsif(note.name.match('b'))
          # Flats are controls, e.g. control_c plays Cb
          @letter = "control_#{@letter}#{note.name.gsub("b", "").downcase}"
        else
          # Otherwise, just a lowercase letter, e.g. c plays C
          @letter += note.name.downcase
        end
      end

      def click_action(key)
        key.press
        Thread.new { key.play(50) }
        shoes.timer(key.note.duration) {
          key.release
          # Callback on click
          click_callback.call if click_callback.respond_to? :call
        }
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
        opts.merge!({
          top: top,
          left: left,
          width: width,
          height: height,
          active_fill: active_fill,
          inactive_fill: inactive_fill,
          text_color: shoes.black
        })
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
        opts.merge!({
          left: (50 + (position * 50)),
          width: width,
          height: 250,
          active_fill: shoes.gray,
          inactive_fill: shoes.black,
          text_color: shoes.white
        })
        super(shoes, position, note, opts)
      end
    end
  end
end