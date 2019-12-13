defmodule Day13Test do
  use ExUnit.Case

  test "part 1 answer: number of blocks" do
    assert Day13.count_blocks() == 205
  end

  test "part 2 answer: final score" do
    assert Day13.final_score() == 10292
  end
end
