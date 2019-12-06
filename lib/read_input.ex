defmodule ReadInput do
  def file(file) do
    File.read!("input/" <> file <> ".txt")
  end

  def lines(file) do
    data = String.split(file(file), "\n", trim: true)
    Enum.map(data, &String.to_integer/1)
  end

  def numbers(file) do
    file = String.trim(file)
    data = String.split(file, ",", trim: true)
    Enum.map(data, &String.to_integer/1)
  end
end
