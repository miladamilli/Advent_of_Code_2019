defmodule Day01 do
  import AdventOfCode2019

  @input "day01"

  def fuel(input) do
    div(input, 3) - 2
  end

  # part one
  def total_count() do
    total(&fuel/1)
  end

  def fuel_for_fuel(input, total) do
    case fuel(input) do
      fuel when fuel <= 0 -> total
      fuel -> fuel_for_fuel(fuel, total + fuel)
    end
  end

  # part two
  def total_count2() do
    total(&fuel_for_fuel(&1, 0))
  end

  def total(function) do
    read_lines(@input)
    |> Enum.map(function)
    |> Enum.sum()
  end
end
