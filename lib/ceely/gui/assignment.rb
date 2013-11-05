require 'shoes'
require 'pry'
module Ceely
  module Gui
    class Assignment
      attr_reader :name, :width, :height
    
      def initialize(name, width=300, height=300)
        @name, @width, @height = name, width, height
      end

      def run(&block)
        raise NoAssignmentError.new unless block_given?
        Shoes.app width: width, height: height, title: name, &block
      end
    end
  
    class NoAssignmentError < RuntimeError
      def initialize()
        super("Looks like you didn't do your assignment.")
      end
    end
  end
end