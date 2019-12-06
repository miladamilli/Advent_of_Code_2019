defmodule Day06 do
  defp read_file() do
    File.read!("input/day06.txt")
  end

  def number_of_orbits() do
    read_file() |> count_orbits()
  end

  def count_orbits(data) do
    map = generate_map(data)
    Enum.map(Map.keys(map), &path_length(&1, nil, map)) |> Enum.sum()
  end

  def transfers_to_santa() do
    read_file() |> shortest_path()
  end

  def shortest_path(data) do
    map = generate_map(data)
    me = path("YOU", nil, map)
    santa = path("SAN", nil, map)
    shared = MapSet.intersection(MapSet.new(me), MapSet.new(santa))
    Enum.map(shared, &(path_length("YOU", &1, map) + path_length("SAN", &1, map))) |> Enum.min()
  end

  defp generate_map(data) do
    data
    |> String.split("\n", trim: true)
    |> Enum.into(%{}, &(String.split(&1, ")") |> Enum.reverse() |> List.to_tuple()))
  end

  defp path_length(orb, to, map, count \\ 0) do
    case map[orb] do
      ^to -> count
      parent -> path_length(parent, to, map, count + 1)
    end
  end

  defp path(orb, to, map, path \\ []) do
    case map[orb] do
      ^to -> path
      parent -> path(parent, to, map, [parent | path])
    end
  end
end
