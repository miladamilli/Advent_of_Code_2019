defmodule Day17Test do
  use ExUnit.Case

  test "part 1 answer: intersections alignment" do
    assert Day17.locate_scaffold() == 7780
  end

  test "part 2 answer: go htrough scaffold" do
    assert Day17.go_through_scaffold() == 1_075_882
  end
end
