defmodule Day10Test do
  use ExUnit.Case

  test "asteroid 0" do
    data = """
    .#..#
    .....
    #####
    ....#
    ...##
    """

    assert Day10.calculate(data) == {{3, 4}, 8}
  end

  test "asteroid 1" do
    data = """
    ......#.#.
    #..#.#....
    ..#######.
    .#.#.###..
    .#..#.....
    ..#....#.#
    #..#....#.
    .##.#..###
    ##...#..#.
    .#....####
    """

    assert Day10.calculate(data) == {{5, 8}, 33}
  end

  test "asteroid 2" do
    data = """
    #.#...#.#.
    .###....#.
    .#....#...
    ##.#.#.#.#
    ....#.#.#.
    .##..###.#
    ..#...##..
    ..##....##
    ......#...
    .####.###.
    """

    assert Day10.calculate(data) == {{1, 2}, 35}
  end

  test "asteroid 3" do
    data = """
    .#..#..###
    ####.###.#
    ....###.#.
    ..###.##.#
    ##.##.#.#.
    ....###..#
    ..#.#..#.#
    #..#.#.###
    .##...##.#
    .....#.#..
    """

    assert Day10.calculate(data) == {{6, 3}, 41}
  end

  test "asteroid 4" do
    data = """
    .#..##.###...#######
    ##.############..##.
    .#.######.########.#
    .###.#######.####.#.
    #####.##.#.##.###.##
    ..#####..#.#########
    ####################
    #.####....###.#.#.##
    ##.#################
    #####.##.###..####..
    ..######..##.#######
    ####.##.####...##..#
    .#####..#.######.###
    ##...#.##########...
    #.##########.#######
    .####.#.###.###.#.##
    ....##.##.###..#####
    .#.#.###########.###
    #.#.#.#####.####.###
    ###.##.####.##.#..##
    """

    assert Day10.calculate(data) == {{11, 13}, 210}
  end

  test "vaporize" do
    data = """
    .#..##.###...#######
    ##.############..##.
    .#.######.########.#
    .###.#######.####.#.
    #####.##.#.##.###.##
    ..#####..#.#########
    ####################
    #.####....###.#.#.##
    ##.#################
    #####.##.###..####..
    ..######..##.#######
    ####.##.####...##..#
    .#####..#.######.###
    ##...#.##########...
    #.##########.#######
    .####.#.###.###.#.##
    ....##.##.###..#####
    .#.#.###########.###
    #.#.#.#####.####.###
    ###.##.####.##.#..##
    """

    assert Day10.vaporize(data) == 802
  end

  test "part 1 answer: number of asteroids visible from best position" do
    {_position, asteroids_number} = Day10.run1()
    assert asteroids_number == 314
  end

  test "part 2 answer" do
    assert Day10.run2() == 1513
  end
end
