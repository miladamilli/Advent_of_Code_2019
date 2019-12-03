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
    intersections =
      find_intersections(wire1, wire2)
      |> MapSet.delete({0, 0})

    closest_intersection =
      intersections
      |> MapSet.to_list()
      |> Enum.map(fn {x, y} -> abs(x) + abs(y) end)
      |> Enum.min()

    IO.inspect(closest_intersection)
  end

  def find_intersections(wire1, wire2) do
    wire1 = Enum.map(find_wire_path(wire1), fn {position, _count} -> position end)
    wire2 = Enum.map(find_wire_path(wire2), fn {position, _count} -> position end)

    MapSet.intersection(MapSet.new(wire1), MapSet.new(wire2))
  end

  defp find_wire_path(wire) do
    wire = String.split(wire, ",", trim: true)
    wire_path(wire, {0, 0}, 0, [])
  end

  def wire_path([], _position, _count, path) do
    path
  end

  def wire_path([step | rest_steps], position, count, path) do
    {direction, steps} = analyze_step(step)

    {path, position, count} = move(direction, steps, position, count, path)

    wire_path(rest_steps, position, count, path)
  end

  @directions %{?R => {1, 0}, ?L => {-1, 0}, ?U => {0, 1}, ?D => {0, -1}}
  defp analyze_step(<<direction::utf8, step::binary>>) do
    {@directions[direction], String.to_integer(step)}
  end

  defp move(_direction, 0, position, count, path) do
    {path, position, count}
  end

  defp move({x1, y1} = direction, steps, {x, y}, count, path) do
    new_point = {x + x1, y + y1}
    new_count = count + 1
    move(direction, steps - 1, new_point, new_count, [{new_point, new_count} | path])
  end

  # part two
  def part_two_shortest_path() do
    [wire1, wire2] = read_input()
    find_shortest_path(wire1, wire2)
  end

  def find_shortest_path(wire1, wire2) do
    wire1_path = find_wire_path(wire1)
    wire2_path = find_wire_path(wire2)

    wire1_positions = Enum.map(wire1_path, fn {position, _count} -> position end)
    wire2_positions = Enum.map(wire2_path, fn {position, _count} -> position end)

    intersections =
      MapSet.intersection(MapSet.new(wire1_positions), MapSet.new(wire2_positions))
      |> MapSet.to_list()

    intersections = intersections -- [{0, 0}]

    wire1 =
      Enum.filter(wire1_path, fn {position, _count} -> position in intersections end)
      |> Map.new()

    wire2 =
      Enum.filter(wire2_path, fn {position, _count} -> position in intersections end)
      |> Map.new()

    {_position, distance} =
      Map.merge(wire1, wire2, fn _position, count1, count2 -> count1 + count2 end)
      |> Enum.min_by(fn {_pos, distance} -> distance end)

    IO.inspect(distance)
  end
end
