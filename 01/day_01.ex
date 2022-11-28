defmodule Day01 do
  def hello_aoc do
    :hello_aoc
  end
end

ExUnit.start()

defmodule Day01Test do
  use ExUnit.Case

  test "it works" do
    assert :hello_aoc = Day01.hello_aoc()
  end
end
