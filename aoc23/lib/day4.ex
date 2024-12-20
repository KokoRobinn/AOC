defmodule Day4 do
  def main do
    test = "Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53\nCard 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19\nCard 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1\nCard 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83\nCard 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36\nCard 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11"
    input = test# File.read!("inputs/day4.inp")
    |> String.split("\n")
    |> Enum.map(&String.replace(&1, ~r/Card\s+\d+:\s/, "")
      |> String.split(" | ") |> List.to_tuple())

    Enum.map(input, &get_matches(&1)) |> Enum.sum()#get_points(0)
  end

  @spec get_matches({binary(), binary()}) :: integer()
  def get_matches({winners, numbers}) do
    win_set = String.split(winners) |> MapSet.new()
    num_set = String.split(numbers) |> MapSet.new()
    MapSet.intersection(win_set, num_set) |> MapSet.size()
  end

  @spec get_points(list(), integer()) :: any()
  def get_points([copies | rest], sum) do
    points = Enum.take(rest, copies)
    get_points(points ++ rest, sum + Enum.count(points))
  end

  def get_points([], sum) do
    sum
  end
end
