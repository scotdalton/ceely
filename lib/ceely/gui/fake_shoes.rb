# Class used for testing.
module Ceely
  module Gui
    module FakeMethods
      def fake_methods
        []
      end

      def method_missing(method_name, *args, &block)
        (respond_to_missing? method_name) ? "Fake #{method_name}" : super
      end

      def respond_to_missing?(method_name, include_private = false)
        fake_methods.include?(method_name) || super
      end
    end

    class FakeShoes
      include Ceely::Gui::FakeMethods
      def fake_methods
        [ :gui, :darkgray, :white, :darkslategray, :background, :strokewidth,
          :keypress, :blue, :timer ]
      end

      def fake_shoe(*args)
        FakeShoe.new(1)
      end
      alias :rect :fake_shoe
      alias :check :fake_shoe
      alias :para :fake_shoe
      alias :subtitle :fake_shoe
      alias :stack :fake_shoe
      alias :flow :fake_shoe
  
      class FakeShoe
        include Ceely::Gui::FakeMethods
        attr_accessor :left, :right, :top, :bottom, :height, :width

        def initialize(seed)
          @left = seed
          @right = seed
          @width = seed
          @top = seed
          @bottom = seed
          @height = seed
        end

        def fake_methods
          [ :click, :unslot, :remove, :checked?, :contents, :replace, :clear ]
        end
      end
    end
  end
end
