defmodule Day09Test do
  use ExUnit.Case

  test "output 2" do
    program = Day09.load_program("1102,34915192,34915192,7,4,7,99,0")
    computer = Day09.init_computer(program, 1)
    output = Day09.run_program(computer).output
    assert length(Integer.digits(output)) == 16
  end

  test "output 3" do
    program = Day09.load_program("104,1125899906842624,99")
    computer = Day09.init_computer(program, 1)
    assert Day09.run_program(computer).output == 1_125_899_906_842_624
  end

  test "part 1 answer" do
    assert Day09.run1() == 4_234_906_522
  end

  test "part 2 answer" do
    assert Day09.run2() == 60962
  end
end
