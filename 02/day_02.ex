defmodule Day02 do
  @win_map %{
    "rock" => "scissors",
    "scissors" => "paper",
    "paper" => "rock"
  }

  @opp_map %{
    "A" => "rock",
    "B" => "paper",
    "C" => "scissors"
  }

  @player_map %{
    "X" => "rock",
    "Y" => "paper",
    "Z" => "scissors"
  }

  @points %{
    "rock" => 1,
    "paper" => 2,
    "scissors" => 3
  }

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

  defp determine_round([opp_hand, player_hand]) do
    opp_move = Map.get(@opp_map, opp_hand)
    player_move = Map.get(@player_map, player_hand)
    points = Map.get(@points, player_move)

    win = 
      case Map.get(@win_map, player_move) do
        ^opp_move -> points + 6
        _ -> 0
      end

    loss = 
      case Map.get(@win_map, opp_move) do
        ^player_move -> points
        _ -> 0
      end

    draw = if opp_move == player_move, do: 3 + points, else: 0

    Enum.sum([win, loss, draw])
  end

  # draw
  defp force_round([opp_hand, "Y"] = _round) do
    opp_move = Map.get(@opp_map, opp_hand)

    {_, player_move} = 
      Enum.find(@player_map, 0, fn({_key, value}) ->
        opp_move == value
      end)

    Map.get(@points, player_move) + 3
  end

  # lose
  defp force_round([opp_hand, "X"] = _round) do
    opp_move = Map.get(@opp_map, opp_hand)
    losing_move = Map.get(@win_map, opp_move)

    Map.get(@points, losing_move)
  end

  # win
  defp force_round([opp_hand, "Z"] = _round) do
    opp_move = Map.get(@opp_map, opp_hand)

    {winning_move, _} = Enum.find(@win_map, "", fn({_win, lose}) ->
      lose == opp_move
    end)

    Map.get(@points, winning_move) + 6
  end

  defp force_round(_), do: 0
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
