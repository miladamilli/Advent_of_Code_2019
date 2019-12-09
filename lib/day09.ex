defmodule Day09 do
  @input_file "day09"
  @phases1 [0, 1, 2, 3, 4]
  @phases2 [5, 6, 7, 8, 9]

  def largest_output1() do
    do_largest_output(load_file(@input_file), generate_phases(@phases1))
  end

  def largest_output2() do
    do_largest_output(load_file(@input_file), generate_phases(@phases2))
  end

  defp load_file(file) do
    file |> ReadInput.file()
  end

  def do_largest_output(data, list_phases) do
    program = load_program(data)

    Enum.map(list_phases, &(start_comps(program, &1) |> run_comps(0)))
    |> Enum.max()
  end

  defp run_comps([c1, c2, c3, c4, c5], input) do
    %{output: output} = c1_new = run_program(%{c1 | input: c1.input ++ [input]})
    %{output: output} = c2_new = run_program(%{c2 | input: c2.input ++ [output]})
    %{output: output} = c3_new = run_program(%{c3 | input: c3.input ++ [output]})
    %{output: output} = c4_new = run_program(%{c4 | input: c4.input ++ [output]})
    %{output: output} = c5_new = run_program(%{c5 | input: c5.input ++ [output]})

    cond do
      c5_new.halt -> c5_new.output
      true -> run_comps([c1_new, c2_new, c3_new, c4_new, c5_new], output)
    end
  end

  defp start_comps(program, phases) do
    Enum.map(phases, &init_computer(program, &1))
  end

  defp load_program(data) do
    data
    |> ReadInput.numbers()
    |> Enum.with_index()
    |> Map.new(fn {v, k} -> {k, v} end)
  end

  defp init_computer(program, input) do
    %{program: program, position: 0, input: [input], output: nil, halt: false}
  end

  def generate_phases([]), do: [[]]

  def generate_phases(phases) do
    for elem <- phases, rest <- generate_phases(phases -- [elem]) do
      [elem | rest]
    end
  end

  def run_program(computer) do
    code = computer.program[computer.position]
    code = Enum.take([0, 0, 0, 0] ++ Integer.digits(code), -5)
    run_code(code, computer)
  end

  def run_code([_, _, _, 9, 9], computer) do
    %{computer | halt: true}
  end

  def run_code([_, mode2, mode1, _, 1], %{program: program, position: position} = computer) do
    value1 = address(mode1, position + 1, program)
    value2 = address(mode2, position + 2, program)

    program = %{program | program[position + 3] => value1 + value2}
    run_program(update_computer(computer, program, position + 4))
  end

  def run_code([_, mode2, mode1, _, 2], %{program: program, position: position} = computer) do
    value1 = address(mode1, position + 1, program)
    value2 = address(mode2, position + 2, program)

    program = %{program | program[position + 3] => value1 * value2}
    run_program(update_computer(computer, program, position + 4))
  end

  def run_code([_, _, _, _, 3], %{program: program, position: position} = computer) do
    if computer.input == [] do
      computer
    else
      program = %{program | computer.program[position + 1] => hd(computer.input)}
      computer = %{computer | input: tl(computer.input)}
      run_program(update_computer(computer, program, position + 2))
    end
  end

  def run_code([_, _, mode1, _, 4], %{program: program, position: position} = computer) do
    output = address(mode1, position + 1, program)
    computer = %{computer | output: output}
    run_program(update_computer(computer, program, position + 2))
  end

  def run_code([_, mode2, mode1, _, 5], %{program: program, position: position} = computer) do
    if address(mode1, position + 1, program) != 0 do
      run_program(update_computer(computer, program, address(mode2, position + 2, program)))
    else
      run_program(update_computer(computer, program, position + 3))
    end
  end

  def run_code([_, mode2, mode1, _, 6], %{program: program, position: position} = computer) do
    if address(mode1, position + 1, program) == 0 do
      run_program(update_computer(computer, program, address(mode2, position + 2, program)))
    else
      run_program(update_computer(computer, program, position + 3))
    end
  end

  def run_code([_, mode2, mode1, _, 7], %{program: program, position: position} = computer) do
    if address(mode1, position + 1, program) < address(mode2, position + 2, program) do
      program = %{program | program[position + 3] => 1}
      run_program(update_computer(computer, program, position + 4))
    else
      program = %{program | program[position + 3] => 0}
      run_program(update_computer(computer, program, position + 4))
    end
  end

  def run_code([_, mode2, mode1, _, 8], %{program: program, position: position} = computer) do
    if address(mode1, position + 1, program) == address(mode2, position + 2, program) do
      program = %{program | program[position + 3] => 1}
      run_program(update_computer(computer, program, position + 4))
    else
      program = %{program | program[position + 3] => 0}
      run_program(update_computer(computer, program, position + 4))
    end
  end

  defp update_computer(computer, program, position) do
    %{computer | program: program, position: position}
  end

  defp address(0, address, program), do: program[program[address]]

  defp address(1, address, program), do: program[address]
end
