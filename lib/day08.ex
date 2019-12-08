defmodule Day08 do
  @width 25
  @height 6
  def check_image() do
    fewest_zeros =
      read_file()
      |> Enum.map(&String.to_integer/1)
      |> Enum.chunk_every(@width * @height)
      |> Enum.min_by(&count_digits(&1, 0))

    count_digits(fewest_zeros, 1) * count_digits(fewest_zeros, 2)
  end

  defp count_digits(layer, number) do
    length(Enum.filter(layer, &(&1 == number)))
  end

  def render_image() do
    read_file()
    |> Enum.chunk_every(@width * @height)
    |> render_layers()
    |> Enum.map(&String.replace(&1, "0", " "))
    |> Enum.map(&String.replace(&1, "1", "\u2588"))
    |> Enum.chunk_every(@width)
    |> Enum.map(&to_string(&1))
  end

  defp render_layers([rest]) do
    rest
  end

  defp render_layers([top_layer, bottom_layer | rest]) do
    merged_layer = Enum.zip(top_layer, bottom_layer) |> Enum.map(&merge_layers/1)
    render_layers([merged_layer | rest])
  end

  defp merge_layers({"2", bottom_pixel}), do: bottom_pixel
  defp merge_layers({top_pixel, _}), do: top_pixel

  defp read_file() do
    File.read!("input/day08.txt")
    |> String.trim()
    |> String.codepoints()
  end
end
