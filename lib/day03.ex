defmodule Day03 do
  @input "day03"

  def read_input() do
    File.read!("input/" <> @input <> ".txt") |> String.split("\n", trim: true)
  end

  # part one
  def shortest_distance() do
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

    closest_intersection
  end

  def find_intersections(wire1, wire2) do
    wire1 = get_wire_path(wire1) |> get_wire_positions()
    wire2 = get_wire_path(wire2) |> get_wire_positions()

    MapSet.intersection(MapSet.new(wire1), MapSet.new(wire2))
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

  defp move({dx, dy} = direction, steps, {x, y}, count, path) do
    new_point = {x + dx, y + dy}
    new_count = count + 1
    move(direction, steps - 1, new_point, new_count, [{new_point, new_count} | path])
  end

  # part two
  def shortest_path() do
    [wire1, wire2] = read_input()
    find_shortest_path(wire1, wire2)
  end

  def find_shortest_path(wire1, wire2) do
    wire1_path = get_wire_path(wire1)
    wire2_path = get_wire_path(wire2)

    intersections = get_intersections(wire1_path, wire2_path)

    wire1 = filter_intersections(wire1_path, intersections)
    wire2 = filter_intersections(wire2_path, intersections)

    {_position, distance} =
      Map.merge(wire1, wire2, fn _position, count1, count2 -> count1 + count2 end)
      |> Enum.min_by(fn {_pos, distance} -> distance end)

    distance
  end

  defp get_wire_path(wire) do
    wire = String.split(wire, ",", trim: true)
    wire_path(wire, {0, 0}, 0, [])
  end

  defp get_intersections(wire1, wire2) do
    wire1 = MapSet.new(get_wire_positions(wire1))
    wire2 = MapSet.new(get_wire_positions(wire2))
    MapSet.intersection(wire1, wire2) |> MapSet.to_list()
  end

  defp filter_intersections(wire, intersections) do
    Enum.filter(wire, fn {position, _count} -> position in intersections end)
    |> Map.new()
  end

  defp get_wire_positions(wire) do
    Enum.map(wire, fn {position, _count} -> position end)
  end
end
