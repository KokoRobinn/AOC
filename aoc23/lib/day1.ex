defmodule Day1 do

  def main do
    #input = ["two1nine","eightwothree","abcone2threexyz","xtwone3four","4nineeightseven2","zoneight234","7pqrstsixteen"]
    input = File.read!("inputs/day1.inp") |> String.split("\n")
    partition(input, self())
    receive do
      {:ok, value} -> value
      _ -> raise "Something bad"
    end
  end

  def partition([], parent) do
    send(parent, {:ok, 0})
  end

  def partition([head | tail], parent) do
    me = self()
    spawn(fn -> partition(tail, me) end)
    sum = calc(head)
    receive do
      {:ok, val} ->
        send(parent, {:ok, sum + val})
      _ ->
        raise "Error"
    end
  end

  def calc(<<>>) do
    0
  end

  @spec calc(binary()) :: integer()
  def calc(bin) do
    trimmed = String.downcase(bin)
    |> find_ints(<<>>)
    |> :binary.bin_to_list()
    |> Enum.drop_while(fn char -> 97 <= char and char <= 122 end)
    |> Enum.reverse()
    |> Enum.drop_while(fn char -> 97 <= char and char <= 122 end)
    (Enum.at(trimmed, -1) - 48) * 10 + Enum.at(trimmed, 0) - 48
  end

  def find_ints(<<>>, good) do
    good
  end

  def find_ints(bad, good) do
    case bad do
      "one" <> rest -> find_ints("e" <> rest, good <> "1")
      "two" <> rest -> find_ints("o" <> rest, good <> "2")
      "three" <> rest -> find_ints("e" <> rest, good <> "3")
      "four" <> rest -> find_ints(rest, good <> "4")
      "five" <> rest -> find_ints("e" <> rest, good <> "5")
      "six" <> rest -> find_ints(rest, good <> "6")
      "seven" <> rest -> find_ints("n" <> rest, good <> "7")
      "eight" <> rest -> find_ints("t" <> rest, good <> "8")
      "nine" <> rest -> find_ints("e" <> rest, good <> "9" )
      <<x::binary-size(1), rest::binary>> -> find_ints(rest, good <> x)
    end
  end
end
