defmodule Computer do
  def read_file(file) do
    ReadInput.file(file)
  end

  def run_computer(%{halt: true} = computer), do: computer

  def run_computer(computer, input \\ []) do
    input =
      case input do
        [] -> computer.input
        input -> [input]
      end

    computer = %{computer | input: input}
    code = computer.memory[computer.pc]
    code = Enum.take([0, 0, 0, 0] ++ Integer.digits(code), -5)

    case run_instruction(code, computer) do
      :noinput -> computer
      computer -> run_computer(computer)
    end
  end

  def init_computer(program, input \\ []) do
    input =
      case input do
        [] -> []
        number -> [number]
      end

    program =
      program
      |> ReadInput.numbers()
      |> Enum.with_index()
      |> Map.new(fn {v, k} -> {k, v} end)

    %{memory: program, pc: 0, input: input, output: [], halt: false, relative_base: 0}
  end

  def clear_output(computer) do
    %{computer | output: []}
  end

  defp run_instruction([_, _, _, 9, 9], computer), do: %{computer | halt: true}

  defp run_instruction([mode3, mode2, mode1, _, 1], computer),
    do: op(:add, mode1, mode2, mode3, computer)

  defp run_instruction([mode3, mode2, mode1, _, 2], computer),
    do: op(:multiply, mode1, mode2, mode3, computer)

  defp run_instruction([_, _, mode, _, 3], computer), do: op(:input, mode, computer)
  defp run_instruction([_, _, mode, _, 4], computer), do: op(:output, mode, computer)

  defp run_instruction([_, mode2, mode1, _, 5], computer),
    do: op(:jump_if_true, mode1, mode2, computer)

  defp run_instruction([_, mode2, mode1, _, 6], computer),
    do: op(:jump_if_false, mode1, mode2, computer)

  defp run_instruction([mode3, mode2, mode1, _, 7], computer),
    do: op(:less_than, mode1, mode2, mode3, computer)

  defp run_instruction([mode3, mode2, mode1, _, 8], computer),
    do: op(:equals, mode1, mode2, mode3, computer)

  defp run_instruction([_, _, mode1, _, 9], computer), do: op(:offset, mode1, computer)

  defp op(:input, mode, %{memory: memory, pc: pc} = computer) do
    if computer.input == [] do
      :noinput
    else
      memory = update_memory(memory, read_for_write(mode, pc + 1, computer), hd(computer.input))
      computer = %{computer | input: tl(computer.input)}
      update_computer(computer, memory, pc + 2)
    end
  end

  defp op(:output, mode, %{memory: memory, pc: pc} = computer) do
    computer = %{computer | output: computer.output ++ [read(mode, pc + 1, computer)]}
    update_computer(computer, memory, pc + 2)
  end

  defp op(:offset, mode1, %{pc: pc, relative_base: base} = computer) do
    %{computer | relative_base: base + read(mode1, pc + 1, computer), pc: pc + 2}
  end

  defp op(:add, mode1, mode2, mode3, %{memory: memory, pc: pc} = computer) do
    value1 = read(mode1, pc + 1, computer)
    value2 = read(mode2, pc + 2, computer)
    value3 = read_for_write(mode3, pc + 3, computer)
    memory = update_memory(memory, value3, value1 + value2)
    update_computer(computer, memory, pc + 4)
  end

  defp op(:multiply, mode1, mode2, mode3, %{memory: memory, pc: pc} = computer) do
    value1 = read(mode1, pc + 1, computer)
    value2 = read(mode2, pc + 2, computer)
    value3 = read_for_write(mode3, pc + 3, computer)
    memory = update_memory(memory, value3, value1 * value2)
    update_computer(computer, memory, pc + 4)
  end

  defp op(:less_than, mode1, mode2, mode3, %{memory: memory, pc: pc} = computer) do
    value3 = read_for_write(mode3, pc + 3, computer)

    if read(mode1, pc + 1, computer) < read(mode2, pc + 2, computer) do
      memory = update_memory(memory, value3, 1)
      update_computer(computer, memory, pc + 4)
    else
      memory = update_memory(memory, value3, 0)
      update_computer(computer, memory, pc + 4)
    end
  end

  defp op(:equals, mode1, mode2, mode3, %{memory: memory, pc: pc} = computer) do
    value3 = read_for_write(mode3, pc + 3, computer)

    if read(mode1, pc + 1, computer) == read(mode2, pc + 2, computer) do
      memory = update_memory(memory, value3, 1)
      update_computer(computer, memory, pc + 4)
    else
      memory = update_memory(memory, value3, 0)
      update_computer(computer, memory, pc + 4)
    end
  end

  defp op(:jump_if_true, mode1, mode2, %{memory: memory, pc: pc} = computer) do
    if read(mode1, pc + 1, computer) != 0 do
      update_computer(computer, memory, read(mode2, pc + 2, computer))
    else
      update_computer(computer, memory, pc + 3)
    end
  end

  defp op(:jump_if_false, mode1, mode2, %{memory: memory, pc: pc} = computer) do
    if read(mode1, pc + 1, computer) == 0 do
      update_computer(computer, memory, read(mode2, pc + 2, computer))
    else
      update_computer(computer, memory, pc + 3)
    end
  end

  defp update_computer(computer, memory, pc) do
    %{computer | memory: memory, pc: pc}
  end

  defp update_memory(memory, pc, value) do
    Map.put(memory, pc, value)
  end

  defp read(0, address, %{memory: memory}),
    do: read_memory(memory[read_memory(memory[address])])

  defp read(1, address, %{memory: memory}), do: read_memory(memory[address])

  defp read(2, address, %{memory: memory, relative_base: relative_base}),
    do: read_memory(memory[read_memory(memory[address]) + relative_base])

  defp read_for_write(0, address, %{memory: memory}),
    do: read_memory(memory[address])

  defp read_for_write(2, address, %{memory: memory, relative_base: relative_base}),
    do: read_memory(memory[address]) + relative_base

  defp read_memory(nil), do: 0
  defp read_memory(value), do: value
end
