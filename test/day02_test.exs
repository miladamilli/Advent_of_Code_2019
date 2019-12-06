defmodule Day02Test do
  use ExUnit.Case

  test "intcode program" do
    input1 = ReadInput.numbers("1,0,0,0,99")
    assert Day02.decode(input1, input1) == "2,0,0,0,99"

    input2 = ReadInput.numbers("2,3,0,3,99")
    assert Day02.decode(input2, input2) == "2,3,0,6,99"

    input3 = ReadInput.numbers("2,4,4,5,99,0")
    assert Day02.decode(input3, input3) == "2,4,4,5,99,9801"

    input4 = ReadInput.numbers("1,1,1,4,99,5,6,0,99")
    assert Day02.decode(input4, input4) == "30,1,1,4,2,5,6,0,99"
  end

  test "part 1 answer" do
    assert Day02.intcode_program() == "3654868"
  end

  test "part 2 answer" do
    assert Day02.find_input_pair() == 7014
  end
end
