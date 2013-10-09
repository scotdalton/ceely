module Ceely
  module Harmonic
    # A Harmonic::Note is an Note with the factor equal to the index
    class Note < Ceely::Note

      # A harmonic note has a factor that is a multiple of the fundamental
      # which means it's the same as the index of the relationship
      def factor
        @factor ||= Rational(index+1)
      end
    end

    # A Harmonic::Scale is a Scale with the set of Harmonic::Notes
    class Scale < Ceely::Scale
    end
  end
end
