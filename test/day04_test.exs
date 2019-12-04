defmodule Day04Test do
  use ExUnit.Case
  doctest Day03

  test "part one" do
    assert Day04.check_passw(111_111) == true
    assert Day04.check_passw(223_450) == false
    assert Day04.check_passw(123_789) == false
  end

  test "part 1 answer" do
    assert Day04.part_one() == 2814
  end

  test "part two" do
    assert Day04.check_passw2(112_233) == true
    assert Day04.check_passw2(123_444) == false
    assert Day04.check_passw2(111_122) == true
  end

  test "part 2 answer" do
    assert Day04.part_two() == 1991
  end
end
