defmodule Day2 do
  require Record

  def main do
    #gives [[binary()]] where each binary is one pull
    input = File.read!("inputs/day2.inp")
    |> String.split("\n")
    |> Enum.map(&yeet_game(&1) |> String.split(";"))

    Enum.map(input, &Enum.map(&1, fn x -> String.trim(x) end))
    |> Enum.map(&gen_sets(&1, []))
    |> Enum.map(&Enum.reduce(&1, %{red: 0, green: 0, blue: 0}, fn %{red: r1, green: g1, blue: b1}, %{red: r2, green: g2, blue: b2} -> %{red: max(r1, r2), green: max(g1, g2), blue: max(b1, b2)} end))
    #|> find_valid(%{red: 12, green: 13, blue: 14}, {1, []}) # part 1
    |> Enum.map(&calc_power(&1))
    |> IO.inspect()
    |> Enum.sum()
  end

  @spec calc_power(%{
          :blue => integer(),
          :green => integer(),
          :red => integer(),
        }) :: integer()
  def calc_power(%{red: r, green: g , blue: b}) do
    r * g * b
  end

  @spec yeet_game(binary()) :: binary()
  def yeet_game(bin) do
    case bin do
      <<"Game ", _x::binary-size(3), ": ", rest::binary>> -> rest
      <<"Game ", _x::binary-size(2), ": ", rest::binary>> -> rest
      <<"Game ", _x::binary-size(1), ": ", rest::binary>> -> rest
      x -> x
    end
  end

  def gen_sets([], list) do
    list
  end

  @spec gen_sets(list(), list()) :: list()
  def gen_sets([round | rest], list) do
    gen_sets(rest, [String.split(round, ", ") |> gen_set(%{red: 0, green: 0, blue: 0}) | list])
  end

  @spec gen_set(list(), map()) :: map()
  def gen_set([], list) do
    list
  end

  def gen_set([color | rest], round) do
    {x, c} = Integer.parse(color)
    case c do
      " red" -> if round[:red] < x do gen_set(rest, %{round | red: x}) end
      " green" -> if round[:green] < x do gen_set(rest, %{round | green: x}) end
      " blue" -> if round[:blue] < x do gen_set(rest, %{round | blue: x}) end
    end
  end

  def find_valid([], _rule, {_idx, idcs}) do
    idcs
  end

  @spec find_valid(list(), map(), {integer(), list(integer())}) :: list(integer())
  def find_valid([%{red: r, green: g, blue: b} | rounds], %{red: rr, green: gr, blue: br}, {idx, idcs}) do
    IO.inspect({idx, r, g, b})
    if r > rr or g > gr or b > br do
      find_valid(rounds, %{red: rr, green: gr, blue: br}, {idx + 1, idcs})
    else
      find_valid(rounds, %{red: rr, green: gr, blue: br}, {idx + 1, [idx | idcs]})
    end
  end
end
