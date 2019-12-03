defmodule Day03Test do
  use ExUnit.Case
  doctest Day03

  test "find closest intersection" do
    assert Day03.find_closest_intersection("R8,U5,L5,D3", "U7,R6,D4,L4") == 6

    assert Day03.find_closest_intersection(
             "R75,D30,R83,U83,L12,D49,R71,U7,L72",
             "U62,R66,U55,R34,D71,R55,D58,R83"
           ) == 159

    assert Day03.find_closest_intersection(
             "R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51",
             "U98,R91,D20,R16,D67,R40,U7,R15,U6,R7"
           ) == 135
  end

  test "puzzle answer part 1" do
    assert Day03.part_one_distance() == 1519
  end

  test "find shortest path" do
    assert Day03.find_shortest_path("R8,U5,L5,D3", "U7,R6,D4,L4") == 30

    assert Day03.find_shortest_path(
             "R75,D30,R83,U83,L12,D49,R71,U7,L72",
             "U62,R66,U55,R34,D71,R55,D58,R83"
           ) == 610

    assert Day03.find_shortest_path(
             "R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51",
             "U98,R91,D20,R16,D67,R40,U7,R15,U6,R7"
           ) == 410
  end
end
