module Ceely
  module Scale
    # A Scale::Harmonic is a Scale::Base with the set of notes being
    # Note::Harmonics based on a fundamental Note::Base
    class Harmonic < Scale::Base

      def notes
        @notes ||= (1..size).collect do |degree|
          Note::Harmonic.new(fundamental, degree)
        end
      end
    end
  end
end
