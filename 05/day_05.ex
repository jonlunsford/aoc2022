defmodule Day05 do
  @moduledoc """
    input = [
      ["Z", "N"],
      ["M", "C", "D"],
      ["P"]
    ]
  """
  def part_1(input, command_file) do
    command_file
    |> File.stream!()
    |> Stream.map(&parse_command/1)
    |> Enum.reduce(input, fn cmd, input ->
      run_cmd(input, cmd, &move_n/2)
    end)
    |> Enum.map(&List.first(&1))
    |> Enum.join()
  end

  def part_2(input, command_file) do
    command_file
    |> File.stream!()
    |> Stream.map(&parse_command/1)
    |> Enum.reduce(input, fn cmd, input ->
      run_cmd(input, cmd, &move_n_part2/2)
    end)
    |> Enum.map(&List.first(&1))
    |> Enum.join()
  end


  def move([[h1 | rest] = _list1, list2]) do
    [rest, [h1 | list2]]
  end

  def move_n([l1, l2], n) do
    Enum.reduce(1..n, [l1, l2], fn _, acc -> move(acc) end)
  end

  def move_n_part2([l1, l2], n) do
    to_move = Enum.take(l1, n)
    [Enum.drop(l1, n), to_move ++ l2]
  end

  defp run_cmd(input, [n, f, t], move_func) do
    from_i = f - 1
    to_i = t - 1

    [from, to] =
      move_func.(
        [
          Enum.at(input, from_i),
          Enum.at(input, to_i)
        ],
        n
      )

    input
    |> List.replace_at(from_i, from)
    |> List.replace_at(to_i, to)
  end

  defp parse_command(line) do
    [_, n, _, f, _, t] =
      line
      |> String.trim()
      |> String.split(" ")

    Enum.map([n, f, t], &String.to_integer(&1))
  end
end

ExUnit.start()

defmodule Day05Test do
  use ExUnit.Case

  test "part_1" do
    test_input = [
      ["N", "Z"],
      ["D", "C", "M"],
      ["P"]
    ]

    #final_input = [
      #["D", "T", "W", "N", "L"],
      #["H", "P", "C"],
      #["J", "M", "G", "D", "N", "H", "P", "W"],
      #["L", "Q", "T", "N", "S", "W", "C"],
      #["N", "C", "H", "P"],
      #["B", "Q", "W", "M", "D", "N", "H", "T"],
      #["L", "S", "G", "J", "R", "B", "M"],
      #["T", "R", "B", "V", "G", "W", "N", "Z"],
      #["L", "P", "N", "D", "G", "W"]
    #]

    assert Day05.part_1(test_input, "input-test.txt") == "CMZ"
  end

  test "part_2" do
    test_input = [
      ["N", "Z"],
      ["D", "C", "M"],
      ["P"]
    ]

    #final_input = [
      #["D", "T", "W", "N", "L"],
      #["H", "P", "C"],
      #["J", "M", "G", "D", "N", "H", "P", "W"],
      #["L", "Q", "T", "N", "S", "W", "C"],
      #["N", "C", "H", "P"],
      #["B", "Q", "W", "M", "D", "N", "H", "T"],
      #["L", "S", "G", "J", "R", "B", "M"],
      #["T", "R", "B", "V", "G", "W", "N", "Z"],
      #["L", "P", "N", "D", "G", "W"]
    #]

    assert Day05.part_2(test_input, "input-test.txt") == "MCD"
  end
end
