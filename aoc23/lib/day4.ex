defmodule Day4 do
  def main do
    input = File.read!("inputs/day4.inp")
    |> String.split("\n")
    |> Enum.map(&String.replace(&1, ~r/Card\s+\d+:\s/, "")
      |> String.split(" | ") |> List.to_tuple())

    Enum.map(input, &do_thing(&1)) |> Enum.sum()
  end

  @spec do_thing({binary(), binary()}) :: integer()
  def do_thing({winners, numbers}) do
    win_set = String.split(winners) |> MapSet.new()
    num_set = String.split(numbers) |> MapSet.new()
    isec = MapSet.intersection(win_set, num_set)
    case MapSet.size(isec) do
      0 -> 0
      size -> 2 ** (size - 1)
    end
  end
end
