defmodule Day09Test do
  use ExUnit.Case

  test "output 1" do
    program = "109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99"
    computer = Day09.init_computer(Day09.load_program(program), 1)
    computer = Day09.run_program(computer)
   # IO.inspect computer
  #  assert Enum.join(Map.values(computer.program), ",") == program
  end

  # test "output 2" do
  #   program = Day09.load_program("1102,34915192,34915192,7,4,7,99,0")
  #   computer = Day09.init_computer(program, 1)
  #   output = Day09.run_program(computer).output
  #   assert length(Integer.digits(output)) == 16
  # end
end
