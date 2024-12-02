defmodule Day5 do
  def main do
    input = File.read!("inputs/day4.inp") |> String.split("\n\n") |> Enum.map(String.split("\n"))
  end

  def range_explorer(input, [{src, dst, len} | rest], parent) do
    me = self()
    spawn(fn -> range_explorer(get_dst(input, {src, dst, len}), me) end)
  end

  @spec get_dst(non_neg_integer(), {non_neg_integer(), non_neg_integer(), non_neg_integer()}) :: number()
  def get_dst(input, {dst, src, len}) do
    case input <= src + len and input >= src do
      true -> input - src + dst
      false -> -1
    end
  end

  def get_range(input, layer, all) do
    ranges = Enum.at(all, layer)

  end
end
