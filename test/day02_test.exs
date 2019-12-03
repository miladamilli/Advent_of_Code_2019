defmodule Day02Test do
  use ExUnit.Case
  doctest Day02

  test "intcode program" do
    assert Day02.decode(AdventOfCode2019.read_numbers("1,0,0,0,99")) == "2,0,0,0,99"
    assert Day02.decode(AdventOfCode2019.read_numbers("2,3,0,3,99")) == "2,3,0,6,99"
    assert Day02.decode(AdventOfCode2019.read_numbers("2,4,4,5,99,0")) == "2,4,4,5,99,9801"

    assert Day02.decode(AdventOfCode2019.read_numbers("1,1,1,4,99,5,6,0,99")) ==
             "30,1,1,4,2,5,6,0,99"
  end

  test "puzzle answer part 1" do
    assert Day02.part_one() == "3654868"
  end

  test "puzzle answer part 2" do
    assert Day02.part_two() == 7014
  end
end
