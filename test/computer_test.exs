defmodule ComputerTest do
  use ExUnit.Case

  test "computer 1" do
    program = "104,1125899906842624,99"
    computer = Computer.init_computer(program, 1)
    computer = Computer.run_computer(computer)
    assert hd(computer.output) == 1_125_899_906_842_624
  end

  test "computer 2" do
    program = ReadInput.file("day09")
    computer = Computer.init_computer(program, 2)
    computer = Computer.run_computer(computer)
    assert hd(computer.output) == 60962
  end
end
