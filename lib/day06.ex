defmodule Day06 do
  @input "day06"

  defp read_file() do
    {:ok, file} = File.read("input/" <> @input <> ".txt")
    file
  end

  # part one
  def count_orbits() do
    read_file()
    |> count()
  end

  def count(data) do
    map = generate_map(data)

    for {orb, _} <- map do
      count_orb(orb, map, 0)
    end
    |> Enum.sum()
  end

  defp count_orb(orb, map, count) do
    case map[orb] do
      nil -> count
      orb -> count_orb(orb, map, count + 1)
    end
  end



  def generate_map(data) do
    data
    |> String.split("\n", trim: true)
    |> Enum.into(%{}, fn path ->
      [parent, orb] = String.split(path, ")")
      {orb, parent}
    end)
  end

  # part two

  def path_to_santa() do
    read_file()
    |> shortest_path()
  end

  def shortest_path(data) do
    map = generate_map(data)

    path_to_me = get_orbits("YOU", map, 0, []) |> Enum.into(%{})

    path_to_santa = get_orbits("SAN", map, 0, []) |> Enum.into(%{})

    me = MapSet.new(Enum.map(path_to_me, fn {orb, _} -> orb end))

    santa = MapSet.new(Enum.map(path_to_santa, fn {orb, _} -> orb end))

    shared = MapSet.intersection(me, santa)

    me = Enum.filter(path_to_me, fn {orb, _} -> orb in shared end) |> Enum.into(%{})

    santa = Enum.filter(path_to_santa, fn {orb, _} -> orb in shared end) |> Enum.into(%{})

    map = Map.merge(me, santa, fn _orb, v1, v2 -> v1 + v2 end)
    {_, shortest_path} = Enum.min_by(map, fn {_orb, dist} -> dist end)
    shortest_path
  end

  def get_orbits(object, map, count, path) do
    case map[object] do
      nil -> path
      object -> get_orbits(object, map, count + 1, [{object, count} | path])
    end
  end
end
