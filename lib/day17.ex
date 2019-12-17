defmodule Day17 do
  @input_file "day17"

  def locate_scaffold() do
    computer = start()
    computer = Computer.run_computer(computer)
    show_camera(computer.output)
    map = create_map(computer.output)
    intersections = find_intersections(map)

    Enum.map(intersections, fn {x, y} -> x * y end) |> Enum.sum()
  end

  # original program
  # L,6,R,8,R,12,L,6,L,8,L,10,L,8,R,12,L,6,R,8,R,12,L,6,L,8,L,8,L,10,L,6,L,6,L,10,L,8,R,12,L,8,L,10,L,6,L,6,L,10,L,8,R,12,L,6,R,8,R,12,L,6,L,8,L,8,L,10,L,6,L,6,L,10,L,8,R,12

  @routine 'A,B,A,C,B,C,B,A,C,B\n' ++
             'L,6,R,8,R,12,L,6,L,8\n' ++
             'L,10,L,8,R,12\n' ++
             'L,8,L,10,L,6,L,6\n' ++
             'n\n'

  def go_through_scaffold() do
    computer = start()
    computer = %{computer | memory: %{computer.memory | 0 => 2}}
    computer = Computer.run_computer(computer, @routine)
    show_camera(computer.output)
    hd(Enum.reverse(computer.output))
  end

  defp find_intersections(map) do
    positions = Map.keys(map)

    Enum.filter(positions, fn {x, y} ->
      {x + 1, y} in positions && {x - 1, y} in positions && {x, y + 1} in positions &&
        {x, y - 1} in positions
    end)
  end

  defp create_map(data) do
    Enum.scan(data, {{-1, 0}, nil}, fn cam_output, location ->
      case cam_output do
        ?\n ->
          {{_x, y}, _} = location
          {{-1, y + 1}, nil}

        ?. ->
          {{x, y}, _} = location
          {{x + 1, y}, nil}

        _ ->
          {{x, y}, _} = location
          {{x + 1, y}, "#"}
      end
    end)
    |> Enum.reject(fn {_position, object} -> object == nil end)
    |> Enum.into(%{})
  end

  defp show_camera(data) do
    IO.puts(IO.ANSI.home())
    IO.puts(data)
  end

  defp start() do
    program = ReadInput.file(@input_file)
    Computer.init_computer(program)
  end
end
