defmodule Day09 do
  @input_file "day09"

  def run() do
    program = @input_file |> ReadInput.file() |> load_program()
    computer = init_computer(program, 1)

    run_program(computer).output
  end

  def load_program(data) do
    data
    |> ReadInput.numbers()
    |> Enum.with_index()
    |> Map.new(fn {v, k} -> {k, v} end)
  end

  def init_computer(program, input) do
    %{memory: program, position: 0, input: [input], output: nil, halt: false, relative_base: 0}
  end

  def run_program(%{halt: true} = computer), do: computer

  def run_program(computer) do
    code = computer.memory[computer.position]
    code = Enum.take([0, 0, 0] ++ Integer.digits(code), -4)
    computer = run_instr(code, computer)
    run_program(computer)
  end

  defp run_instr([_, _, 9, 9], computer), do: %{computer | halt: true}
  defp run_instr([mode2, mode1, _, 1], computer), do: op(:add, mode1, mode2, computer)
  defp run_instr([mode2, mode1, _, 2], computer), do: op(:multiply, mode1, mode2, computer)
  defp run_instr([_, _, _, 3], computer), do: op(:input, computer)
  defp run_instr([_, mode1, _, 4], computer), do: op(:output, mode1, computer)
  defp run_instr([mode2, mode1, _, 5], computer), do: op(:nonzero, mode1, mode2, computer)
  defp run_instr([mode2, mode1, _, 6], computer), do: op(:zero, mode1, mode2, computer)
  defp run_instr([mode2, mode1, _, 7], computer), do: op(:less, mode1, mode2, computer)
  defp run_instr([mode2, mode1, _, 8], computer), do: op(:equal, mode1, mode2, computer)
  defp run_instr([_, mode1, _, 9], computer), do: op(:offset, mode1, computer)

  defp op(:input, %{memory: memory, position: position} = computer) do
    if computer.input == [] do
      computer
    else
      memory = update_memory(memory, memory[position + 1], hd(computer.input))
      computer = %{computer | input: tl(computer.input)}
      update_computer(computer, memory, position + 2)
    end
  end

  defp op(:add, mode1, mode2, %{memory: memory, position: position} = computer) do
    value1 = read(mode1, position + 1, computer)
    value2 = read(mode2, position + 2, computer)
    #  IO.inspect  value1 + value2
    memory = update_memory(memory, memory[position + 3], value1 + value2)
    update_computer(computer, memory, position + 4)
  end

  defp op(:multiply, mode1, mode2, %{memory: memory, position: position} = computer) do
    value1 = read(mode1, position + 1, computer)
    value2 = read(mode2, position + 2, computer)

    # if program[position + 3] == 1000 do
    #   IO.inspect  value2
    # end
    # IO.inspect  value1

    memory = update_memory(memory, memory[position + 3], value1 * value2)
    update_computer(computer, memory, position + 4)
  end

  defp op(:nonzero, mode1, mode2, %{memory: memory, position: position} = computer) do
    if read(mode1, position + 1, computer) != 0 do
      update_computer(
        computer,
        memory,
        read(mode2, position + 2, computer)
      )
    else
      update_computer(computer, memory, position + 3)
    end
  end

  defp op(:zero, mode1, mode2, %{memory: memory, position: position} = computer) do
    if read(mode1, position + 1, computer) == 0 do
      update_computer(
        computer,
        memory,
        read(mode2, position + 2, computer)
      )
    else
      update_computer(computer, memory, position + 3)
    end
  end

  defp op(:less, mode1, mode2, %{memory: memory, position: position} = computer) do
    if read(mode1, position + 1, computer) < read(mode2, position + 2, computer) do
      memory = update_memory(memory, memory[position + 3], 1)
      update_computer(computer, memory, position + 4)
    else
      memory = update_memory(memory, memory[position + 3], 0)
      update_computer(computer, memory, position + 4)
    end
  end

  defp op(:equal, mode1, mode2, %{memory: memory, position: position} = computer) do
    if read(mode1, position + 1, computer) == read(mode2, position + 2, computer) do
      memory = update_memory(memory, memory[position + 3], 1)
      update_computer(computer, memory, position + 4)
    else
      memory = update_memory(memory, memory[position + 3], 0)
      update_computer(computer, memory, position + 4)
    end
  end

  defp op(:output, mode1, %{memory: memory, position: position} = computer) do
    output = read(mode1, position + 1, computer)
    computer = %{computer | output: output}
    update_computer(computer, memory, position + 2)
  end

  defp op(:offset, mode1, %{position: position, relative_base: base} = computer) do
    %{
      computer
      | relative_base: base + read(mode1, position + 1, computer),
        position: position + 2
    }
  end

  defp update_computer(computer, memory, position) do
    %{computer | memory: memory, position: position}
  end

  defp update_memory(memory, position, value) do
    Map.put(memory, position, value)
  end

  defp read(0, address, %{memory: memory}),
    do: read_memory(memory[read_memory(memory[address])])

  defp read(1, address, %{memory: memory}), do: read_memory(memory[address])

  defp read(2, address, %{memory: memory, relative_base: relative_base}),
    do: read_memory(memory[read_memory(memory[address]) + relative_base])

  defp read_memory(nil), do: 0
  defp read_memory(value), do: value
end
