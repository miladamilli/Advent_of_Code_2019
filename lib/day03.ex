defmodule Day03 do
  @input "day03"

  def read_input() do
    {:ok, file} = File.read("input/" <> @input <> ".txt")
    String.split(file, "\n", trim: true)
  end

  # part one
  def part_one_distance() do
    [wire1, wire2] = read_input()
    find_closest_intersection(wire1, wire2)
  end

  def find_closest_intersection(wire1, wire2) do
    intersections = find_intersections(wire1, wire2) -- [{0, 0}]

    closest_intersection =
      Enum.map(intersections, fn {x, y} -> abs(x) + abs(y) end)
      |> Enum.min()

    IO.inspect(closest_intersection)
  end

  defp find_wire_path(wire) do
    wire = String.split(wire, ",", trim: true)
    wire_path(wire)
  end

  def find_intersections(wire1, wire2) do
    wire1 = find_wire_path(wire1)
    wire2 = find_wire_path(wire2)

    MapSet.intersection(MapSet.new(wire1), MapSet.new(wire2))
    |> MapSet.to_list()
  end

  def wire_path(steps) do
    Enum.scan(steps, [{0, 0}], fn step, origin -> next_step(step, Enum.at(origin, -1)) end)
    |> List.flatten()
  end

  defp next_step(<<direction::utf8>> <> step, {x, y}) do
    step = String.to_integer(step)

    case direction do
      ?R -> for x <- x..(x + step), do: {x, y}
      ?L -> for x <- x..(x - step), do: {x, y}
      ?D -> for y <- y..(y - step), do: {x, y}
      ?U -> for y <- y..(y + step), do: {x, y}
    end
  end
end
