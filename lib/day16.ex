defmodule Day16 do
  @input_file "day16"

  @pattern [0, 1, 0, -1]

  def after_100_phases() do
    read_input(@input_file) |> calculate()
  end

  def with_offset_and_10_000() do
    read_input(@input_file) |> calculate_10_000()
  end

  def calculate_10_000(data) do
    data = parse_data_10_000(data)
    offset = offset(data)
    data = Enum.drop(data, offset)

    Stream.iterate(data, &calculate_end/1)
    |> Enum.at(100)
    |> Enum.take(8)
    |> Integer.undigits()
  end

  defp calculate_end(data) do
    calculate_end(Enum.reverse(data), [], 0)
  end

  defp calculate_end([n | rest], output, previous) do
    new_n = rem(n + previous, 10)
    calculate_end(rest, [new_n | output], new_n)
  end

  defp calculate_end([], output, _previous) do
    output
  end

  defp parse_data_10_000(data) do
    data = String.graphemes(data) |> Enum.map(&String.to_integer/1)
    Enum.flat_map(1..10000, fn _ -> data end)
  end

  defp offset(data) do
    Enum.take(data, 7) |> Integer.undigits()
  end

  def calculate(data) do
    data
    |> parse_data()
    |> Stream.iterate(&run_phases/1)
    |> Enum.at(100)
    |> Enum.take(8)
    |> Integer.undigits()
  end

  defp run_phases(data) do
    length = length(data)

    for position <- 1..length do
      pattern = get_pattern(@pattern, position, length)

      Enum.zip(data, pattern)
      |> Enum.map(fn {a, b} -> a * b end)
      |> Enum.sum()
      |> rem(10)
      |> abs()
    end
  end

  defp parse_data(data) do
    data
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
  end

  defp get_pattern(pattern, multiple, length) do
    multiply_pattern(pattern, multiple)
    |> Stream.cycle()
    |> Stream.drop(1)
    |> Enum.take(length)
  end

  defp multiply_pattern(pattern, multiple) do
    for v <- pattern, _ <- 1..multiple do
      v
    end
  end

  defp read_input(file) do
    file
    |> ReadInput.file()
    |> String.trim()
  end
end
