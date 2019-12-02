defmodule AdventOfCode2019 do
  @moduledoc """
  Documentation for AdventOfCode2019.
  """

  def read_lines(file) do
    {:ok, file} = File.read("input/" <> file <> ".txt")
    data = String.split(file, "\n", trim: true)
    Enum.map(data, &String.to_integer/1)
  end
end
