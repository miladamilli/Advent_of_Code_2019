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
    check_increasing(passw) and check_number_group([-1] ++ passw ++ [-1])
  end

  defp check_increasing([a, b, c, d, e, f]) do
    a <= b and b <= c and c <= d and d <= e and e <= f
  end

  defp check_number_group([a, b, c, d | _] = [_ | rest]) do
    case b == c and b != a and b != d do
      true -> true
      _ -> check_number_group(rest)
    end
  end

  defp check_number_group(_) do
    false
  end
end
