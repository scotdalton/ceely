$: <<  File.dirname(__FILE__)+'/../lib'
require 'ceely'
INDEXES = %w{ 0 1 2 3 4 5 6 }
HARMONIES = %w{ Third Fourth Fifth }
SCALES = %w{ Zarlino Harmonic Pythagorean Dodecaphonic Ptolemaic EvenTempered }
Ceely::Gui::Assignment.new("Quiz", 400, 400).run do
  flow margin: 20, width: 400, height: 400 do
    background lightgray, curve: 20
    border darkred, curve: 20, strokewidth: 1
    stack margin: 10 do
      subtitle "Quiz"
    end
    stack margin: 10 do
      button("Question 9") do
        pythagorean = Ceely::Scales::Pythagorean::Scale.new(400)
        pythagorean.duration = 3
        harmonic = Ceely::Scales::Harmonic::Scale.new(400)
        harmonic.duration = 3
        pythagorean_third = pythagorean.note_by_type("M3")
        pythagorean_third.duration = 3
        harmonic_third = harmonic.note_by_type("M3")
        harmonic_third.duration = 3
        pythagorean_third.play(50)
        chord = Ceely::Chord.new(3, pythagorean_third, harmonic_third)
        p pythagorean_third.frequency.to_f
        p harmonic_third.frequency.to_f
        chord.play(50)
      end
    end
    stack margin: 10 do
      button("Question 10") do
        pythagorean = Ceely::Scales::Pythagorean::Scale.new(400)
        harmonic = Ceely::Scales::Harmonic::Scale.new(400)
        pythagorean_first = pythagorean.note_by_type("1")
        pythagorean_third = pythagorean.note_by_type("M3")
        pythagorean_chord = Ceely::Chord.new(3, pythagorean_first, pythagorean_third)
        pythagorean_chord.play(50)
        pythagorean_chord.play(50)
        harmonic_first = harmonic.note_by_type("1")
        harmonic_third = harmonic.note_by_type("M3")
        harmonic_chord = Ceely::Chord.new(3, harmonic_first, harmonic_third)
        p pythagorean_first.frequency.to_f
        p harmonic_first.frequency.to_f
      end
    end
  end
end
