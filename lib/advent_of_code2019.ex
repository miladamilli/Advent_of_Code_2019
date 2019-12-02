defmodule AdventOfCode2019 do
  @moduledoc """
  Documentation for AdventOfCode2019.
  """

  def read_file(file) do
    {:ok, file} = File.read("input/" <> file <> ".txt")
    file
  end

  def read_lines(file) do
    data = String.split(read_file(file), "\n", trim: true)
    Enum.map(data, &String.to_integer/1)
  end

  def read_numbers(file) do
    file  = String.trim(file)
    data = String.split(file, ",", trim: true)
    Enum.map(data, &String.to_integer/1)

  end
end
