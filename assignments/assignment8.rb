$: <<  File.dirname(__FILE__)+'/../lib'
require 'ceely'
INDEXES = %w{ -5 -4 -3 -2 -1 0 1 2 3 4 5 6 }
Ceely::Gui::Assignment.new("Assignment 7", 700, 750).run do
  @wheel = Ceely::BeatWheel.new
  def refresh_results
    @wheel = Ceely::BeatWheel.new(@tempo.text.to_f).rotate!(@cycle.text.to_i)
    @cycle_para.replace "Cycle: ", em(@wheel.ordered_cycles.index(@wheel.current_cycle))
    @beats_para.replace "Beats/Pauses(X/.) for This Cycle: ", em(@wheel.current_cycle_to_s)
  end
  cycle, loops = 0, 1
  flow width: 700, height: 750 do
    flow margin: 20, width: 350, height: 375 do
      background lightgray, curve: 20
      border darkred, curve: 20, strokewidth: 1
      stack margin: 10 do
        subtitle "Wheel of Bembe"
      end
      stack margin: 10 do
        para "Cycle: "
        @cycle = edit_line(cycle)
      end
      flow(margin: 10) do
        para("Choose the seconds/beats: ")
        @tempo = edit_line(0.5)
      end
      stack margin: 10 do
        button("Refresh the Beats Display") do
          refresh_results
        end
      end
      stack margin: 10 do
        button("Play this Cycle") do
          refresh_results
          Thread.new { @wheel.play_current_cycle(50) }
        end
      end
    end
    flow margin: 20, width: 350, height: 375 do
      background lightgray, curve: 20
      border darkred, curve: 20, strokewidth: 1
      flow margin: 10 do
        subtitle("Jam")
      end
      stack margin: 10 do
        para "Number of Loops to Jam: "
        @loops = edit_line(loops)
      end
      stack margin: 10 do
        button("Jam") do
          refresh_results
          loops = @loops.text.to_i
          wheel = @wheel
          Thread.new { wheel.jam(50, loops) }
        end
      end
    end
    flow margin: 20, width: 700, height: 375 do
      background lightgray, curve: 20
      border darkred, curve: 20, strokewidth: 1
      flow margin: 10 do
        subtitle("The Beats (X=beat/.=pause)")
      end
      flow margin: 10 do
        @cycle_para = para ""
      end
      flow margin: 10 do
        @beats_para = para ""
      end
      flow margin: 10 do
        @all_beats = para "All beats in the wheel:\n#{@wheel.to_s}"
      end
      refresh_results
    end
  end
end
