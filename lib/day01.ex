defmodule Day01 do
  def read() do
    {:ok, file} = File.read("input/day01.txt")
    data = String.split(file, "\n", trim: true)
    Enum.map(data, &String.to_integer/1)
  end

  def fuel(input) do
    trunc(input / 3) - 2
  end

  # part one solution
  def total_count() do
    values = read()

    Enum.map(values, fn value -> fuel(value) end)
    |> Enum.sum()
  end

  def fuel_for_fuel(input, total) do
    fuel = fuel(input)

    if fuel <= 0 do
      total
    else
      fuel_for_fuel(fuel, total + fuel)
    end
  end

  # part two solution
  def total_count2() do
    values = read()

    Enum.map(values, fn value -> fuel_for_fuel(value, 0) end)
    |> Enum.sum()
  end
end
