require 'spec_helper'
module Ceely
  describe Ceely::BeatWheel do
    expected_rhythms = rhythms
    context "before it's been rotated" do
      subject(:beat_wheel) { Ceely::BeatWheel.new }

      describe '#tempo' do
        it 'has the tempo we expect' do
          expect(beat_wheel.tempo).to eq(0.5)
        end
      end

      describe '#current_cycle' do
        it 'has the current cycle we expect' do
          expect(beat_wheel.current_cycle.collect{ |beat| beat.to_s }.join(" ")).to eq(expected_rhythms.first)
        end
      end

      describe '#play' do
        it 'plays without error' do
          expect{ beat_wheel.play(50) }.not_to raise_error
        end
      end

      describe '#loop' do
        it 'loops without error' do
          expect{ beat_wheel.loop(2, 50) }.not_to raise_error
        end
      end

      describe '#to_s' do
        it 'has the value we expect' do
          expect(beat_wheel.to_s).to eq(expected_rhythms.join("\n"))
        end
      end
    end

    rhythms.each_with_index do |rhythm, index|
      context "when it's the #{index} cycle," do
        subject(:beat_wheel) { Ceely::BeatWheel.new.rotate!(index) }
    
        describe '#tempo' do
          it 'has the tempo we expect' do
            expect(beat_wheel.tempo).to eq(0.5)
          end
        end
    
        describe '#current_cycle' do
          it 'has the current cycle we expect' do
            expect(beat_wheel.current_cycle.collect{ |beat| beat.to_s }.join(" ")).to eq(rhythm)
          end
        end
    
        describe '#play' do
          it 'plays without error' do
            expect{ beat_wheel.play(50) }.not_to raise_error
          end
        end
    
        describe '#loop' do
          it 'loops without error' do
            expect{ beat_wheel.loop(2, 50) }.not_to raise_error
          end
        end
      end
    end
  end
end
