defmodule Day04 do
  @range 109_165..576_723

  # part one
  def part_one() do
    valid_passwords = Enum.filter(@range, &check_passw/1)
    length(valid_passwords)
  end

  def check_passw(passw) do
    passw = Integer.digits(passw)
    check_increasing(passw) and check_adjacent(passw)
  end

  defp check_adjacent([a, b, c, d, e, f]) do
    a == b or b == c or c == d or d == e or e == f
  end

  def part_two() do
    valid_passwords = Enum.filter(@range, &check_passw2/1)
    length(valid_passwords)
  end

  def check_passw2(passw) do
    passw = Integer.digits(passw)
    check_increasing(passw) and check_number_group(passw)
  end

  defp check_increasing([a, b, c, d, e, f]) do
    a <= b and b <= c and c <= d and d <= e and e <= f
  end

  defp check_number_group([a, a, c, _, _, _]) when a != c, do: true
  defp check_number_group([a, b, b, c, _, _]) when b != a and b != c, do: true
  defp check_number_group([_, b, c, c, d, _]) when c != b and c != d, do: true
  defp check_number_group([_, _, c, d, d, e]) when d != c and d != e, do: true
  defp check_number_group([_, _, _, d, e, e]) when e != d, do: true
  defp check_number_group(_), do: false
end
