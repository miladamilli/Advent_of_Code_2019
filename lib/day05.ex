defmodule Day05 do
  @input_file "day05"
  @input1 1
  @input2 5

  # part one
  def run1(), do: do_run(@input1)

  # part two
  def run2(), do: do_run(@input2)

  def do_run(input) do
    input_data =
      @input_file
      |> ReadInput.file()
      |> ReadInput.numbers()
      |> Enum.with_index()
      |> Map.new(fn {v, k} -> {k, v} end)

    computer = %{program: input_data, position: 0, input: input, output: nil}
    run_program(computer).output
  end

  def run_program(computer) do
    code = computer.program[computer.position]
    code = Enum.take([0, 0, 0, 0] ++ Integer.digits(code), -5)
    run_code(code, computer)
  end

  def run_code([_, _, _, 9, 9], computer) do
    computer
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
    program = %{program | computer.program[position + 1] => computer.input}

    run_program(update_computer(computer, program, position + 2))
  end

  def run_code([_, _, mode1, _, 4], %{program: program, position: position} = computer) do
    output = address(mode1, position + 1, program)
    run_program(update_computer(computer, program, position + 2, output))
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

  defp update_computer(computer, program, position, output \\ nil) do
    %{computer | program: program, position: position, output: output}
  end

  defp address(0, address, program), do: program[program[address]]

  defp address(1, address, program), do: program[address]
end
