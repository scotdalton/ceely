require 'spec_helper'
module Ceely
  describe Ceely::Song do
    context "when it's a Pythagorean song," do
      subject(:scale) { Ceely::Pythagorean::Scale.new }
      subject(:tempo) { 1 }
      subject(:song) { Ceely::Song.new(scale, tempo) }
      subject(:u) { scale.sort.find { |note| note.type.eql? "1" } }
      subject(:minor_3) { scale.sort.find { |note| note.type.eql? "m3" } }
      subject(:major_3) { scale.sort.find { |note| note.type.eql? "M3" } }
      subject(:p5) { scale.sort.find { |note| note.type.eql? "5" } }
      subject(:minor_chord) { Ceely::Chord.new(u, minor_3, p5) }
      subject(:major_chord) { Ceely::Chord.new(u, major_3, p5) }

      describe '#key' do
        it 'has the Pythagorean key' do
          expect(song.key).to be_a(Ceely::Pythagorean::Scale)
        end
      end

      describe '#tempo' do
        it 'has a tempo of 1' do
          expect(song.tempo).to be(1)
        end
      end

      describe '#note_by_name!' do
        it 'can add a note by name' do
          expect { song.note_by_name!("B") }.not_to raise_error
        end

        it 'returns self' do
          expect(song.note_by_name!("B")).to be(song)
        end
      end

      describe '#note_by_type!' do
        it 'can add a note by type' do
          expect { song.note_by_type!("M3") }.not_to raise_error
        end

        it 'returns self' do
          expect(song.note_by_type!("M3")).to be(song)
        end
      end

      describe '#note!' do
        it 'can add a note' do
          expect { song.note!(u) }.not_to raise_error
        end

        it 'returns self' do
          expect(song.note!(u)).to be(song)
        end
      end

      describe '#notes_by_name!' do
        it 'can add notes by name' do
          expect { song.notes_by_name!(*%w{ B A G A B B B }) }.not_to raise_error
        end

        it 'returns self' do
          expect(song.notes_by_name!(*%w{ B A G A B B B })).to be(song)
        end
      end

      describe '#notes_by_type!' do
        it 'can add notes by type' do
          expect { song.notes_by_type!(*%w{ 1 M3 5 }) }.not_to raise_error
        end

        it 'returns self' do
          expect(song.notes_by_type!(*%w{ 1 M3 5 })).to be(song)
        end
      end

      describe '#notes!' do
        it 'can add notes' do
          expect { song.notes!(u, p5) }.not_to raise_error
        end

        it 'returns self' do
          expect(song.notes!(u, p5)).to be(song)
        end
      end

      describe '#chord_by_names!' do
        it 'can add a chord by note names' do
          expect { song.chord_by_names!(*%w{ C E G }) }.not_to raise_error
        end

        it 'returns self' do
          expect(song.chord_by_names!(*%w{ C E G })).to be(song)
        end
      end

      describe '#chord_by_types!' do
        it 'can add a chord by note types' do
          expect { song.chord_by_types!(*%w{ 1 M3 5 }) }.not_to raise_error
        end

        it 'returns self' do
          expect(song.chord_by_types!(*%w{ 1 M3 5 })).to be(song)
        end
      end

      describe '#chord!' do
        it 'can add a chord' do
          expect { song.chord!(major_chord) }.not_to raise_error
        end
      end

      describe '#chords!' do
        it 'can add chords' do
          expect { song.chords!(major_chord, minor_chord) }.not_to raise_error
        end

        it 'returns self' do
          expect(song.chords!(major_chord, minor_chord)).to be(song)
        end
      end

      describe '#pause!' do
        it 'can add a pause' do
          expect { song.pause!() }.not_to raise_error
        end

        it 'can add half a pause' do
          expect { song.pause!(0.5) }.not_to raise_error
        end

        it 'returns self' do
          expect(song.pause!()).to be(song)
        end
      end

      describe '#<<' do
        it 'can add playables' do
          expect { song << major_chord }.not_to raise_error
        end

        it 'returns self' do
          expect(song << major_chord).to be(song)
        end

        it 'can chain playables' do
          expect { song << major_chord << minor_chord << u }.not_to raise_error
        end

        it 'errors when given an object that\'s not playable' do
          expect { song << nil }.to raise_error(ArgumentError)
        end
      end
    end

    context "when it's Mary as a Pythagorean song," do
      subject(:scale) { Ceely::Pythagorean::Scale.new }
      subject(:tempo) { 1 }
      subject(:song) { Ceely::Song.new(scale, tempo) }
      subject(:d) { scale.note_by_name("D") }
      subject(:c) { scale.note_by_name("C") }
      subject(:g) { scale.note_by_name("G") }
      # Don't run this test on travis since
      # we don't have permissions.
      unless(ENV['TRAVIS'].eql? "true")
        describe '#play' do
          it 'plays the song' do
            song.notes_by_name!(*%w{ B A G A B B B })
            song.notes_by_name!(*%w{ A A A B })
            # Add the Ds in the next octave
            song << d.in_octave(1) << d.in_octave(1)
            song.notes_by_name!(*%w{ B A G A B B B })
            song.notes_by_name!(*%w{ B A A B A })
            # End with a power chord
            song.chord_by_names!("C", "G")
            expect { song.play(50) }.not_to raise_error
          end
        end
      end
    end
  end
end
