defmodule Day08Test do
  use ExUnit.Case

  test "part 1 answer" do
    assert Day08.check_image() == 2080
  end

  test "part 2 answer" do
    message = [
      " ██  █  █ ███   ██  █   █",
      "█  █ █  █ █  █ █  █ █   █",
      "█  █ █  █ █  █ █     █ █ ",
      "████ █  █ ███  █      █  ",
      "█  █ █  █ █ █  █  █   █  ",
      "█  █  ██  █  █  ██    █  "
    ]

    assert Day08.render_image() == message
  end
end
