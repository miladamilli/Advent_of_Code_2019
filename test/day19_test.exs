defmodule Day19Test do
  use ExUnit.Case

  test "beam area 50x50" do
    assert Day19.beam_area() == 183
  end

  test "closest square 100x100" do
    assert Day19.closest_square_100x100() == 11_221_248
  end
end
