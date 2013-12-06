module Ceely
  module Mixins
    module SyntonicComma

      def syntonic_comma
        @syntonic_comma ||= harmonic_third.interval(pythagorean_third)
      end

      def harmonic_third
        @harmonic_third ||= harmonic.note_by_type("M3")
      end

      def pythagorean_third
        @pythagorean_third ||= pythagorean.note_by_type("M3")
      end

      def harmonic
        @harmonic ||= Ceely::Scales::Harmonic::Scale.new
      end

      def pythagorean
        @pythgorean ||= Ceely::Scales::Pythagorean::Scale.new
      end
    end
  end
end
