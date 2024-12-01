defmodule Day1 do

  def main do
    {left, right} = File.read!("inputs/day1.inp") 
    |> String.split("\n")
    |> List.delete_at(-1)
    |> Enum.reduce({[], []}, fn <<l::binary-size(5), " ", r::binary-size(5)>>, {left, right} -> {[String.to_integer(l) | left], [String.to_integer(r) | right]} end)

    Enum.reduce(left, 0, fn l, score ->
      score + Enum.reduce(right, 0, fn r, sum -> 
        if l == r do
          sum + r 
        else
          sum
        end 
      end)      
    end)

  end
end
