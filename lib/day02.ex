defmodule Day02 do
  @input "day02"
  @value1 12
  @value2 2

  # part one
  def intcode_program() do
    [first, _, _ | rest] = @input |> ReadInput.file() |> ReadInput.numbers()
    data = [first, @value1, @value2 | rest]
    [position0, _] = String.split(decode(data, data), ",", parts: 2)
    position0
  end

  def decode([], all) do
    List.flatten(all) |> Enum.join(",")
  end

  def decode([99 | _rest], all) do
    List.flatten(all) |> Enum.join(",")
  end

  def decode([operation, first, second, value | rest], all) do
    first = Enum.at(all, first)
    second = Enum.at(all, second)
    {part1, part2} = Enum.split(all, value)

    new_value =
      case operation do
        1 -> first + second
        2 -> first * second
      end

    all = List.flatten([part1] ++ [new_value] ++ tl(part2))

    decode(Enum.take(all, -length(rest)), all)
  end

  # part two
  @expected "19690720"
  def find_input_pair() do
    [first, _, _ | rest] = ReadInput.file(@input) |> ReadInput.numbers()

    input_pairs =
      for noun <- 0..99, verb <- 0..99 do
        {noun, verb}
      end

    [{noun, verb}] =
      Enum.filter(input_pairs, fn {noun, verb} ->
        data = [first, noun, verb | rest]
        match?(@expected <> _, decode(data, data))
      end)

    100 * noun + verb
  end
end
