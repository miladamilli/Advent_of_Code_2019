defmodule Day01Test do
  use ExUnit.Case

  test "part one: fuel for a module" do
    assert Day01.fuel(12) == 2
    assert Day01.fuel(14) == 2
    assert Day01.fuel(1969) == 654
    assert Day01.fuel(100_756) == 33583
  end

  test "part two: fuel for fuel" do
    assert Day01.fuel_for_fuel(12, 0) == 2
    assert Day01.fuel_for_fuel(1969, 0) == 966
    assert Day01.fuel_for_fuel(100_756, 0) == 50346
  end

  test "part 1 answer" do
    assert Day01.total_fuel() == 3_386_686
  end

  test "part 2 answer" do
    assert Day01.total_fuel2() == 5_077_155
  end
end
