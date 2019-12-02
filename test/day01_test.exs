defmodule Day01Test do
  use ExUnit.Case
  doctest Day01

  test "fuel for a module" do
    assert Day01.fuel(12) == 2
    assert Day01.fuel(14) == 2
    assert Day01.fuel(1969) == 654
    assert Day01.fuel(100_756) == 33583
  end

  test "fuel for fuel" do
    assert Day01.fuel_for_fuel(12, 0) == 2
    assert Day01.fuel_for_fuel(1969, 0) == 966
    assert Day01.fuel_for_fuel(100_756, 0) == 50346
  end

  test "puzzle answer part 1" do
    assert Day01.total_count() == 3_386_686
  end

  test "puzzle answer part 2" do
    assert Day01.total_count2() == 5_077_155
  end
end
