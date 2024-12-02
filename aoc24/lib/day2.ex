defmodule Day2 do

  def main do
    File.read!("inputs/day2.inp") 
#"7 6 4 2 1
#1 2 7 8 9
#9 7 6 2 1
#1 3 2 4 5
#8 6 4 4 1
#1 3 6 7 9"
    |> String.split("\n")
    |> IO.inspect()
    |> List.delete_at(-1) 
    |> Enum.map(fn ln -> String.split(ln, " ") 
      |> Enum.map(&String.to_integer(&1)) end)
    |> IO.inspect(charlists: :as_lists)
    |> Enum.map(&check_safe(&1, 0))
    |> IO.inspect()
    |> Enum.count(fn x -> x == true end)
  end

  @spec sign(integer()) :: integer()
  def sign(int) when int < 0 do -1 end
  def sign(_int) do 1 end

  @spec check_safe([integer()], integer()) :: boolean()
  def check_safe([_bah], _s) do
    true
  end

  @spec check_safe([integer()], integer()) :: boolean()
  def check_safe([fst | [snd | line]], s) do 
    diff = fst - snd
    abs_diff = abs(diff)
    abs_diff <= 3 and abs_diff > 0 and sign(diff) != -s and check_safe([snd | line], sign(diff))
  end

end
