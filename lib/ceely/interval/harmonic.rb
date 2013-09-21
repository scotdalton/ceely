module Ceely
  module Interval
    # A Harmonic is an Interval with the factor equal to the index
    class Harmonic < Interval::Base

      # A harmonic interval has a factor that is a multiple of the fundamental
      # which means it's the same as the index of the relationship
      def factor
        @factor ||= Rational(index+1)
      end
    end
  end
end
