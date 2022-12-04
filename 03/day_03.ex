defmodule Day03 do
  def part_1(file) do
    file
    |> File.stream!()
    |> Stream.map(&determine_contents/1)
    |> Enum.to_list()
    |> Enum.sum()
  end

  def part_2(file) do
    file
    |> File.stream!()
    |> Stream.chunk_every(3)
    |> Stream.map(&determine_group/1)
    |> Enum.to_list()
    |> List.flatten()
    |> Enum.sum()
  end

  defp determine_group(lines) do
    [a, b, c] = Enum.map(lines, &String.split(&1, "", trim: true))
    d = a -- a -- b
    result = hd(d -- d -- c)

    find_values([result])
  end

  defp determine_contents(string) do
    string
    |> String.trim()
    |> String.split("")
    |> split_in_half()
    |> find_overlap([])
    |> find_values()
  end

  defp split_in_half(list) do
    len = round(length(list)/2)
    {a, b} = Enum.split(list, len) 

    [
      Enum.join(a),
      Enum.join(b)
    ]
  end

  defp find_overlap(list, acc) when length(list) == 1, do: acc

  defp find_overlap([head | rest], acc) do
    result = 
      String.myers_difference(head, List.first(rest))
      |> Keyword.get(:eq)
      |> String.split(" ")

    acc = acc ++ result

    find_overlap(rest, acc)
  end

  defp find_values([letter]) do
    lower =
      ?a..?z 
      |> Enum.find_index(fn x -> to_string([x]) == letter end)

    upper =
      ?A..?Z 
      |> Enum.find_index(fn x -> to_string([x]) == letter end)

    cond do
      !is_nil(lower) -> lower + 1
      !is_nil(upper) -> upper + 27
    end
  end
end

ExUnit.start()

defmodule Day03Test do
  use ExUnit.Case

  test "part_1 - it does the thing" do
    assert Day03.part_1("input-test.txt") == 157
  end

  test "part_2 - it does the thing" do
    assert Day03.part_2("input-test.txt") == 70
  end
end

