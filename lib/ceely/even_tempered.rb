module Ceely
  module EvenTempered
    # An EvenTempered::Note is a Note with the factor equal to 3/2
    class Note < Ceely::Note

      # A even tempered note has a factor equal to 12 root 2
      # raised to the power of the index
      def factor
        @factor ||= (2 ** (1.0/12))**index
      end
    end

    # An EvenTempered::Scale is a Scale with a set EvenTempered::Notes
    class Scale < Ceely::Scale
    end
  end
end
