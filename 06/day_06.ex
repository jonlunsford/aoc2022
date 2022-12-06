defmodule Day06 do
  def part_1(file) do
    file
    |> parse_file()
    |> count_up_to(4)
  end

  def part_2(file) do
    file
    |> parse_file()
    |> count_up_to(14)
  end

  defp count_up_to(list_with_index, up_to) do
    Enum.reduce_while(list_with_index, 0, fn {_char, i}, acc ->
      count = 
        Enum.slice(list_with_index, i, up_to)
        |> Enum.map(fn {c, _} -> c end)
        |> Enum.uniq()
        |> Enum.count()

      case count do
        ^up_to -> {:halt, i + up_to}
          _ -> {:cont, acc}
      end
    end)
  end

  defp parse_file(file) do
    file
    |> File.read!()
    |> String.split("", trim: true)
    |> Enum.reject(fn x -> x == "\n" end)
    |> Enum.with_index()
  end
end

ExUnit.start()

defmodule Day06Test do
  use ExUnit.Case

  test "part_1" do
    assert Day06.part_1("input-test.txt") == 7
  end

  test "part_2" do
    assert Day06.part_2("input-test.txt") == 19
  end
end
