defmodule Day05Test do
  use ExUnit.Case

  defp parse_input(input) do
    input |> ReadInput.numbers() |> Enum.with_index() |> Map.new(fn {v, k} -> {k, v} end)
  end

  defp computer(program), do: %{program: program, position: 0, input: 1, output: nil}

  defp list(computer) do
    computer |> Map.to_list() |> Enum.map(fn {_k, v} -> v end) |> Enum.join(",")
  end

  test "intcode program" do
    comp1 = parse_input("1,0,0,0,99") |> computer()
    assert Day05.run_program(comp1).program |> list() == "2,0,0,0,99"

    comp2 = parse_input("2,3,0,3,99") |> computer()
    assert Day05.run_program(comp2).program |> list() == "2,3,0,6,99"

    comp3 = parse_input("2,4,4,5,99,0") |> computer()
    assert Day05.run_program(comp3).program |> list() == "2,4,4,5,99,9801"

    comp4 = parse_input("1,1,1,4,99,5,6,0,99") |> computer()
    assert Day05.run_program(comp4).program |> list() == "30,1,1,4,2,5,6,0,99"
  end

  test "part 1 answer" do
    assert Day05.run1() == 7_988_899
  end

  test "part 2 answer" do
    assert Day05.run2() == 13_758_663
  end
end
