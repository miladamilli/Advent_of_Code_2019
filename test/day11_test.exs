defmodule Day11Test do
  use ExUnit.Case

  test "part 1 answer" do
    assert Day11.run1() == 2016
  end

  test "part 2 answer" do
    message = [
      " ███   ██  ███  ███   ██  ███  ███  █  █   ",
      " █  █ █  █ █  █ █  █ █  █ █  █ █  █ █  █   ",
      " █  █ █  █ █  █ █  █ █    ███  █  █ ████   ",
      " ███  ████ ███  ███  █    █  █ ███  █  █   ",
      " █ █  █  █ █    █ █  █  █ █  █ █    █  █   ",
      " █  █ █  █ █    █  █  ██  ███  █    █  █   "
    ]

    assert Day11.run2() == message
  end
end
