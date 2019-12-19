defmodule Day19 do
  @input_file "day19"
  def beam_area() do
    computer = start_computer()

    for x <- 0..49, y <- 0..49, reduce: 0 do
      acc ->
        [beam] = Computer.run_computer(computer, [x, y]).output
        acc + beam
    end
  end

  def closest_square_100x100() do
    computer = start_computer()
    {x, y} = find_point_in_beam(computer, 0, 0)
    x * 10000 + y
  end

  defp find_point_in_beam(computer, x, y) do
    [output1] = Computer.run_computer(computer, [x + 99, y]).output
    [output2] = Computer.run_computer(computer, [x, y + 99]).output

    case {output1, output2} do
      {1, 1} -> {x, y}
      {0, 1} -> find_point_in_beam(computer, x, y + 1)
      {1, 0} -> find_point_in_beam(computer, x + 1, y)
      _ -> find_point_in_beam(computer, x + 1, y + 1)
    end
  end

  defp start_computer() do
    @input_file |> ReadInput.file() |> Computer.init_computer()
  end
end
