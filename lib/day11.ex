defmodule Day11 do
  @input_file "day11"

  def run1() do
    program = ReadInput.file(@input_file)
    computer = Computer.init_computer(program)
    map = run_robot({0, 0}, :up, %{{0, 0} => 0}, computer)
    length(Map.keys(map))
  end

  def run2() do
    program = ReadInput.file(@input_file)
    computer = Computer.init_computer(program)
    map = run_robot({0, 0}, :up, %{{0, 0} => 1}, computer)
    paint(map)
  end

  defp paint(map) do
    coords = Map.keys(map)
    {min_x, _} = Enum.min_by(coords, fn {x, _y} -> x end)
    {_, min_y} = Enum.min_by(coords, fn {_x, y} -> y end)
    {max_x, _} = Enum.max_by(coords, fn {x, _y} -> x end)
    {_, max_y} = Enum.max_by(coords, fn {_x, y} -> y end)

    image =
      for y <- min_y..max_y do
        for x <- min_x..max_x do
          case map[{x, y}] do
            1 -> "\u2588"
            _ -> " "
          end
        end
      end

    Enum.map(image, &to_string/1)
  end

  def run_robot(_pos, _dir, map, %{halt: true}) do
    map
  end

  def run_robot(pos, dir, map, computer) do
    panel_color =
      case map[pos] do
        nil -> 0
        color -> color
      end

    computer = Computer.run_computer(computer, panel_color)
    [color, turn] = computer.output
    map = Map.put(map, pos, color)
    computer = Computer.clear_output(computer)
    new_dir = turn(dir, turn)
    new_pos = step(pos, new_dir)
    run_robot(new_pos, new_dir, map, computer)
  end

  @dirs [:up, :right, :down, :left]
  defp turn(direction, turn) do
    index = Enum.find_index(@dirs, fn dir -> dir == direction end)

    case turn do
      0 -> Enum.at(@dirs, index - 1)
      1 -> Enum.at(@dirs, rem(index + 1, 4))
    end
  end

  defp step({x, y}, :down), do: {x, y + 1}
  defp step({x, y}, :up), do: {x, y - 1}
  defp step({x, y}, :right), do: {x + 1, y}
  defp step({x, y}, :left), do: {x - 1, y}
end
