defmodule Day03 do
  @input "day03"

  def read_input() do
    {:ok, file} = File.read("input/" <> @input <> ".txt")
    String.split(file, "\n", trim: true)
  end

  def part_one_distance() do
    [wire1, wire2] = read_input()

    calculate_distance(wire1, wire2)
  end

  def calculate_distance(wire1, wire2) do
    wire1 = String.split(wire1, ",", trim: true)

    wire2 = String.split(wire2, ",", trim: true)
    IO.inspect(wire1_path = wire_path(wire1) -- [{0, 0}])
    IO.inspect(wire2_path = wire_path(wire2) -- [{0, 0}])
    intersections = MapSet.intersection(MapSet.new(wire1_path), MapSet.new(wire2_path))

    closest_intersection =
      Enum.map(intersections, fn {x, y} -> abs(x) + abs(y) end)
      |> Enum.min()

    IO.inspect(closest_intersection)
  end

  def wire_path(steps, origin \\ {0, 0}, path \\ [])

  def wire_path([], _, path) do
    path
  end

  def wire_path([step | remaining_steps], origin, path) do
    IO.inspect(new_steps = next_step(step, origin))
    wire_path(remaining_steps, Enum.at(new_steps, -1), path ++ new_steps)
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
