defmodule Day01 do
  @input "day01"

  # part one
  def total_fuel() do
    count_fuel(&fuel/1)
  end

  def fuel(input) do
    div(input, 3) - 2
  end

  # part two
  def total_fuel2() do
    count_fuel(&fuel_for_fuel(&1, 0))
  end

  def fuel_for_fuel(input, total) do
    case fuel(input) do
      fuel when fuel <= 0 -> total
      fuel -> fuel_for_fuel(fuel, total + fuel)
    end
  end

  defp count_fuel(function) do
    ReadInput.lines(@input)
    |> Enum.map(function)
    |> Enum.sum()
  end
end
