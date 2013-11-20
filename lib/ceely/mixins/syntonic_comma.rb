module Ceely
  module Mixins
    module SyntonicComma

      def syntonic_comma
        return @syntonic_comma if defined? @syntonic_comma
        harmonic_third = harmonic.note_by_type("M3")
        pythagorean_third = pythagorean.note_by_type("M3")
        @syntonic_comma = harmonic_third.interval(pythagorean_third)
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
