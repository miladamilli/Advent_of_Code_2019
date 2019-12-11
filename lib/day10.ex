defmodule Day10 do
  def run1() do
    calculate(File.read!("input/day10.txt"))
  end

  def calculate(data) do
    data_to_map(data)
    |> find_best_position()
  end

  def run2() do
    vaporize(File.read!("input/day10.txt"))
  end

  def vaporize(data) do
    map = data_to_map(data)
    {best, _visible} = find_best_position(map)
    run_laser(map, best)
  end

  defp find_best_position(map) do
    Enum.map(map, fn {k, _v} -> visible(k, Map.keys(map)) end)
    |> Enum.max_by(fn {_pos, visible} -> visible end)
  end

  defp visible({x, y}, all) do
    map = Enum.map(all -- [{x, y}], fn {dx, dy} -> get_vector_and_dist({x, y}, {dx, dy}) end)

    visible = Enum.group_by(map, fn {_pos, {vector, _dist}} -> vector end) |> Map.to_list()

    {{x, y}, length(visible)}
  end

  defp run_laser(map, best) do
    map_for_laser =
      map_vectors_and_dist(best, Map.delete(map, best))
      |> Enum.group_by(fn {_pos, {vector, _dist}} -> vector end)
      |> Enum.map(fn {k, v} -> {k, Enum.sort_by(v, fn {_pos, {_vector, dist}} -> dist end)} end)
      |> Enum.into(%{})

    Map.keys(map_for_laser)
    |> Enum.sort(&sort_vector/2)
    |> laser(map_for_laser, 1)
  end

  defp sort_vector({q1, {x1, y1}}, {q2, {x2, y2}}) do
    {q1, x1 / y1} < {q2, x2 / y2}
  end

  defp laser([vector | _rest], map, 200) do
    {{x, y}, _} = hd(map[vector])
    x * 100 + y
  end

  defp laser([vector | rest], map, count) do
    case map[vector] do
      [] ->
        laser(rest, map, count)

      asteroids ->
        laser(rest ++ [vector], %{map | vector => tl(asteroids)}, count + 1)
    end
  end

  defp map_vectors_and_dist(origin, map) do
    Enum.map(Map.delete(map, origin), fn {k, _v} -> get_vector_and_dist(origin, k) end)
  end

  defp get_vector_and_dist({x, y}, {dx, dy}) do
    dist_x = dx - x
    dist_y = dy - y
    vector = vector(dist_x, dist_y)
    dist = :math.sqrt(dist_x * dist_x + dist_y * dist_y)
    {{dx, dy}, {vector, dist}}
  end

  def vector(x, y) do
    gcd = Integer.gcd(x, y)
    x = div(x, gcd)
    y = div(y, gcd)

    cond do
      x >= 0 && y < 0 -> {:q1, {x, -y}}
      x > 0 && y >= 0 -> {:q2, {y, x}}
      x <= 0 && y > 0 -> {:q3, {-x, y}}
      x < 0 && y <= 0 -> {:q4, {-y, -x}}
    end
  end

  defp parse([], _line_nr, map) do
    map
  end

  defp parse([line | rest], line_nr, map) do
    map = parse_line(line, line_nr, 0, map)
    parse(rest, line_nr + 1, map)
  end

  defp parse_line([], _line_nr, _pos_nr, map) do
    map
  end

  defp parse_line([position | rest], line_nr, pos_nr, map) do
    if position == "#" do
      map = Map.put(map, {pos_nr, line_nr}, nil)
      parse_line(rest, line_nr, pos_nr + 1, map)
    else
      parse_line(rest, line_nr, pos_nr + 1, map)
    end
  end

  def data_to_map(data) do
    data
    |> String.split("\n", trim: true)
    |> Enum.map(&String.graphemes/1)
    |> parse(0, %{})
  end
end
