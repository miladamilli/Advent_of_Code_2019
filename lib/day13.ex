defmodule Day13 do
  @input_file "day13"

  def count_blocks() do
    computer = start_game()
    computer = Computer.run_computer(computer, 0)
    {map, _score} = render_screen(computer.output, %{}, nil)

    Enum.filter(map, fn {_position, tile} -> tile == :block end)
    |> length()
  end

  def final_score do
    computer = start_game()
    computer = %{computer | memory: %{computer.memory | 0 => 2}}
    IO.puts(IO.ANSI.clear())
    run_game(computer, %{}, 0, nil)
  end

  def start_game() do
    program = ReadInput.file(@input_file)
    Computer.init_computer(program)
  end

  defp run_game(%{halt: true}, _map, _joystick, score) do
    score
  end

  defp run_game(computer, map, joystick, score) do
    computer = Computer.clear_output(computer)
    computer = Computer.run_computer(computer, joystick)

    {map, score} = render_screen(computer.output, map, score)
    Process.sleep(10)
    print_screen(map)
    IO.puts(score)
    [{{player_x, _}, _}] = Enum.filter(map, fn {_position, tile} -> tile == :paddle end)
    [{{ball_x, _}, _}] = Enum.filter(map, fn {_position, tile} -> tile == :ball end)

    cond do
      player_x < ball_x -> run_game(computer, map, 1, score)
      player_x > ball_x -> run_game(computer, map, -1, score)
      player_x == ball_x -> run_game(computer, map, 0, score)
    end
  end

  defp render_screen([], map, score) do
    {map, score}
  end

  defp render_screen([-1, 0, score | output], map, _) do
    render_screen(output, map, score)
  end

  defp render_screen([x, y, tile_id | output], map, score) do
    map =
      case tile_id do
        0 -> Map.put(map, {x, y}, :empty)
        1 -> Map.put(map, {x, y}, :wall)
        2 -> Map.put(map, {x, y}, :block)
        3 -> Map.put(map, {x, y}, :paddle)
        4 -> Map.put(map, {x, y}, :ball)
      end

    render_screen(output, map, score)
  end

  defp print_screen(map) do
    coords = Map.keys(map)
    {min_x, _} = Enum.min_by(coords, fn {x, _y} -> x end)
    {_, min_y} = Enum.min_by(coords, fn {_x, y} -> y end)
    {max_x, _} = Enum.max_by(coords, fn {x, _y} -> x end)
    {_, max_y} = Enum.max_by(coords, fn {_x, y} -> y end)

    image =
      for y <- min_y..max_y do
        for x <- min_x..max_x do
          case map[{x, y}] do
            :empty -> " "
            :wall -> "\u2588"
            :block -> "\u2592"
            :paddle -> "\u25AC"
            :ball -> "\u25CF"
          end
        end
      end

    IO.puts(IO.ANSI.home())

    image
    |> Enum.map(&to_string/1)
    |> Enum.intersperse("\n")
    |> IO.puts()
  end
end
