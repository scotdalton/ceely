module Ceely
  module Gui
    module ShoeElement
      require 'shoes'
      attr_reader :shoes, :gui, :shoe
      attr_reader :left, :top, :width, :height
      
      def initialize(shoes, opts={})
        @shoes, @gui = shoes, shoes.gui
        @width = opts.delete(:width)
        @height = opts.delete(:height)
        @left = opts.delete(:left)
        @top = opts.delete(:top)
      end
    end
  end
end
