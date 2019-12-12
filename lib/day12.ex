defmodule Day12 do
  @moons [
    {12, 0, -15, 0, 0, 0},
    {-8, -5, -10, 0, 0, 0},
    {7, -17, 1, 0, 0, 0},
    {2, -11, -6, 0, 0, 0}
  ]

  @moons_by_coords [
    {[12, -8, 7, 2], [0, 0, 0, 0]},
    {[0, -5, -17, -11], [0, 0, 0, 0]},
    {[-15, -10, 1, -6], [0, 0, 0, 0]}
  ]
  def total_energy() do
    rotate(@moons, 1000)
  end

  def matching_state() do
    [x, y, z] = Enum.map(@moons_by_coords, fn coord -> same_coords(coord, coord, 0) end)
    calculate_steps(x, y, z)
  end

  def calculate_steps(x, y, z) do
    n = div(x * y, Integer.gcd(x, y))
    div(n * z, Integer.gcd(n, z))
  end

  def same_coords(coord, coord, steps) when steps > 1 do
    steps
  end

  def same_coords(coord_orig, {moons = [a, b, c, d], [av, bv, cv, dv]}, steps) do
    [ag, bg, cg, dg] = Enum.map(moons, fn moon -> gravity(moon, moons -- [moon]) end)
    av = av + ag
    bv = bv + bg
    cv = cv + cg
    dv = dv + dg
    same_coords(coord_orig, {[a + av, b + bv, c + cv, d + dv], [av, bv, cv, dv]}, steps + 1)
  end

  defp gravity(moon, [b, c, d]) do
    asses(moon, b) + asses(moon, c) + asses(moon, d)
  end

  defp asses(moon, other_moon) do
    cond do
      moon > other_moon -> -1
      moon < other_moon -> 1
      moon == other_moon -> 0
    end
  end

  def rotate(moons, 0) do
    Enum.map(moons, &calculate_energy/1)
    |> Enum.sum()
  end

  def rotate(moons, steps) do
    Enum.map(moons, &update_position(&1, moons -- [&1]))
    |> rotate(steps - 1)
  end

  defp calculate_energy({ax, ay, az, ax_v, ay_v, az_v}) do
    (abs(ax) + abs(ay) + abs(az)) * (abs(ax_v) + abs(ay_v) + abs(az_v))
  end

  defp update_position({x, y, z, x_v, y_v, z_v}, [
         {bx, by, bz, _bx_v, _by_v, _bz_v},
         {cx, cy, cz, _cx_v, _cy_v, _cz_v},
         {dx, dy, dz, _dx_v, _dy_v, _dz_v}
       ]) do
    x_v = x_v + gravity(x, [bx, cx, dx])
    y_v = y_v + gravity(y, [by, cy, dy])
    z_v = z_v + gravity(z, [bz, cz, dz])

    {x + x_v, y + y_v, z + z_v, x_v, y_v, z_v}
  end
end
