defmodule Day01 do
  def part_1(file_name) do
    file_name
    |> parse_file()
    |> Enum.to_list()
    |> Enum.max()
  end

  def part_2(file_name) do
    file_name
    |> parse_file()
    |> Enum.to_list()
    |> Enum.sort()
    |> Enum.reverse()
    |> Enum.take(3)
    |> Enum.sum()
  end

  defp parse_file(file_name) do
    file_name
    |> File.stream!()
    |> Stream.chunk_by(fn line -> line == "\n" end)
    |> Stream.reject(fn [head | _] -> head == "\n" end)
    |> Stream.map(&sum_list/1)
  end

  defp sum_list(list) do
    list
    |> Enum.map(fn int ->
      case Integer.parse(int) do
        :error-> 0
        {int, _} -> int
      end
    end)
    |> Enum.sum()
  end
end

ExUnit.start()

defmodule Day01Test do
  use ExUnit.Case

  test "part 1 does the thing correctly" do
    assert Day01.part_1("input-test.txt") == 24_000
  end

  test "part 2 also sort of maybe does the thing correctly" do
    assert Day01.part_2("input-test.txt") == 45_000
  end
end
