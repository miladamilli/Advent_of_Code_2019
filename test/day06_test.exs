defmodule Day06Test do
  use ExUnit.Case

  @part1 """
  COM)B
  B)C
  C)D
  D)E
  E)F
  B)G
  G)H
  D)I
  E)J
  J)K
  K)L
  """

  test "count orbits" do
    assert Day06.count_orbits(@part1) == 42
  end

  test "part 1 answer" do
    assert Day06.number_of_orbits() == 122_782
  end

  @part2 """
  COM)B
  B)C
  C)D
  D)E
  E)F
  B)G
  G)H
  D)I
  E)J
  J)K
  K)L
  K)YOU
  I)SAN
  """

  test "count path to santa's orbit" do
    assert Day06.shortest_path(@part2) == 4
  end

  test "part 2 answer" do
    assert Day06.transfers_to_santa() == 271
  end
end
