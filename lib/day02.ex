defmodule Day02 do
  import AdventOfCode2019

  @input "day02"
  @value1 12
  @value2 2
  def part_one() do
    [first, _, _ | rest] =
      @input
      |> read_file()
      |> read_numbers()

    data = [first | [@value1 | [@value2 | rest]]]

    [position0, _] = String.split(decode(data), ",", parts: 2)
    IO.inspect(position0)
  end

  def decode(data) do
    first(data, data)
  end

  def first([], all) do
    List.flatten(all)
    |> Enum.join(",")
  end

  def first([99 | _rest], all) do
    List.flatten(all)
    |> Enum.join(",")
  end

  def first([operation, first, second, value | rest], all) do
    first = Enum.at(all, first)
    second = Enum.at(all, second)
    {part1, part2} = Enum.split(all, value)

    new_value =
      case operation do
        1 -> first + second
        2 -> first * second
      end

    all = List.flatten([part1] ++ [new_value] ++ tl(part2))

    first(Enum.take(all, -length(rest)), all)
  end

  def part_two() do
    data = read_file(@input)
    data = read_numbers(data)

    [first, _, _ | rest] = data

    input_pairs =
      for noun <- 0..99, verb <- 0..99 do
        {noun, verb}
      end

    result =
      Enum.filter(input_pairs, fn {noun, verb} ->
        data = [first | [noun | [verb | rest]]]

        check(first(data, data))
      end)

    [{noun, verb}] = result
    IO.inspect(100 * noun + verb)
  end

  @expected "19690720"
  defp check(@expected <> _), do: true
  defp check(_), do: false
end
