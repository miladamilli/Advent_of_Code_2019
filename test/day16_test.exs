defmodule Day16Test do
  use ExUnit.Case

  test "first 100 phases" do
    input = "80871224585914546619083218645595"

    assert Day16.calculate(input) == 24_176_176
  end

  test "part 1 answer" do
    assert Day16.after_100_phases() == 61_149_209
  end

  test "with 10_000 times larger input and offset, 1" do
    input = "03036732577212944063491565474664"

    assert Day16.calculate_10_000(input) == 84_462_026
  end

  test "with 10_000 times larger input and offset, 2" do
    input = "02935109699940807407585447034323"
    assert Day16.calculate_10_000(input) == 78_725_270
  end

  test "part 2 answer" do
    assert Day16.with_offset_and_10_000() == 16_178_430
  end
end
