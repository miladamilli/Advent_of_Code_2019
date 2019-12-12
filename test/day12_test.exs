defmodule Day12Test do
  use ExUnit.Case

  test "total energy" do
    moons = [{-1, 0, 2, 0, 0, 0}, {2, -10, -7, 0, 0, 0}, {4, -8, 8, 0, 0, 0}, {3, 5, -1, 0, 0, 0}]

    assert Day12.rotate(moons, 10) == 179
  end

  test "part 1 answer: total energy after 1000 steps" do
    assert Day12.total_energy() == 7636
  end

  test "steps to previous matching state" do
    moons = [
      {[-8, 5, 2, 9], [0, 0, 0, 0]},
      {[-10, 5, -7, -8], [0, 0, 0, 0]},
      {[0, 10, 3, -3], [0, 0, 0, 0]}
    ]

    [x, y, z] = Enum.map(moons, fn moon -> Day12.same_coords(moon, moon, 0) end)
    assert Day12.calculate_steps(x, y, z) == 4_686_774_924
  end

  test "part 2 answer: steps to the previous matching state" do
    assert Day12.matching_state() == 281_691_380_235_984
  end
end
