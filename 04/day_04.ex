defmodule Day04 do
  def part_1(input) do
    input
    |> File.stream!()
    |> Stream.map(&parse_input/1)
    |> Stream.filter(&contains?/1)
    |> Enum.to_list()
    |> Enum.count()
  end

  def part_2(input) do
    input
    |> File.stream!()
    |> Stream.map(&parse_input/1)
    |> Stream.filter(&overlaps?/1)
    |> Enum.to_list()
    |> Enum.count()
  end

  defp contains?([{a, b}, {c, d}]) when c >= a and d <= b, do: true
  defp contains?([{a, b}, {c, d}]) when a >= c and b <= d, do: true
  defp contains?(_), do: false

  defp overlaps?([{a, b}, {c, d}]) do
    cond do
      Enum.member?((a..b), c) -> true
      Enum.member?((a..b), d) -> true
      Enum.member?((c..d), a) -> true
      Enum.member?((c..d), b) -> true
      true -> false
    end
  end

  defp parse_input(line) do
    line
    |> String.trim()
    |> String.split(",")
    |> Enum.map(fn pair ->
      [l, r] = String.split(pair, "-")
      {l, _} = Integer.parse(l)
      {r, _} = Integer.parse(r)
      {l, r}
    end)
  end
end

ExUnit.start()

defmodule Day04Test do
  use ExUnit.Case

  test "part_1" do
    assert Day04.part_1("input-test.txt") == 2
  end

  test "part_2" do
    assert Day04.part_2("input-test.txt") == 4
  end
end
