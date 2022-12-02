defmodule Day02 do
  @player_a ["A", "B", "C"]
  @player_b ["X", "Y", "Z"]

  def part_1(file) do
    file
    |> File.stream!()
    |> Stream.map(&parse_lines/1)
    |> Stream.map(&determine_round/1)
    |> Enum.to_list()
    |> Enum.sum()
  end

  def part_2(file) do
    file
    |> File.stream!()
    |> Stream.map(&parse_lines/1)
    |> Stream.map(&force_round/1)
    |> Enum.to_list()
    |> Enum.sum()
  end

  defp parse_lines(round) do
    round
    |> String.trim()
    |> String.split(" ")
  end

  defp determine_round([a, b]) do
    a = Enum.find_index(@player_a, fn x -> x == a end)
    b = Enum.find_index(@player_b, fn x -> x == b end) + 1

    case Integer.mod(b - a, 3) do
      2 -> b
      1 -> b + 6
      0 -> b + 3
    end
  end

  defp force_round([a, b]) do
    a = Enum.find_index(@player_a, fn x -> x == a end) + 1

    case b do
      "X" -> Integer.mod(a - 1, 3)
      "Y" -> a + 3
      "Z" -> Integer.mod(a + 1, 3) + 6
    end
  end
end

ExUnit.start()

defmodule Day02Test do
  use ExUnit.Case

  test "part_1 - Is this some secret code?" do
    assert Day02.part_1("input-test.txt") == 15
  end

  test "part_2 - Yes it is! I now have the power!" do
    assert Day02.part_2("input-test.txt") == 12
  end
end
