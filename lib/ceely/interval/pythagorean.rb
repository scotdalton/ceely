module Ceely
  module Interval
    # A Pythagorean is an Interval with the factor equal to 3/2
    class Pythagorean < Interval::Base

      # A pythagorean interval has a factor equal to 3/2
      # raised to the power of the index
      def factor
        @factor ||= Rational(3, 2)**index
      end
    end
  end
end
