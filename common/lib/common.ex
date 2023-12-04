defmodule Common do
  @moduledoc """
  `Common` is a module for common functions needed for AOC.
  """

  @doc """
  `input` Gets the input field for a given day
  """

  def input(year, day) do
    Base.h Httpoison.get!/1
    response = HTTPoison.get!("https://adventofcode.com/#{year}/day/#{day}/input")
    #req = Poison.decode!(response.body)
  end
end
