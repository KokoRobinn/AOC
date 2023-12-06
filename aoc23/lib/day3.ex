defmodule Day3 do

  def main do
    test = "467..114..\n...*......\n..35..633.\n......#...\n617*......\n.....+.58.\n..592.....\n......755.\n...$.*....\n.664.598.."
    String.duplicate(".", 145) <> "\n" <> File.read!("inputs/day3.inp") <> "\n" <> String.duplicate(".", 145)
    |> String.split("\n")
    |> (Enum.map(&("." <> &1 <> "....")))
    |> stride(1, 0)
  end


  #need to define what happens at end of row without number there

  @spec stride(list(), non_neg_integer(), non_neg_integer()) :: non_neg_integer()
  def stride([line1 | [line2 | [line3 | grid]]], col, sum) do
    <<_passed::binary-size(col-1), focus::binary-size(5), _rest::binary>> = line2
    case {Integer.parse(binary_part(focus, 1, 3)), col + 5 >= 145} do # Is there a number here?
      {:error, false} -> stride([line1 | [line2 | [line3 | grid]]], col + 1, sum) # No
      {:error, true} -> stride([line2 | [line3 | grid]], 1, sum) # NO!
      {{x, _bajs}, _} -> # Yeeees...
        num_len = Integer.digits(x) |> Enum.count()
        <<_passed::binary-size(col-1), roof::binary-size(num_len + 2), _rest::binary>> = line1
        <<_passed::binary-size(col-1), floor::binary-size(num_len + 2), _rest::binary>> = line3
        <<front::binary-size(1), _num::binary-size(num_len), back::binary-size(1), _bajs::binary>> = focus
        chars = front <> back <> roof <> floor
        case {String.match?(chars, ~r/[^1234567890.]/), col + num_len >= 145} do #Are there any cool characters?
          {true, false} -> stride([line1 | [line2 | [line3 | grid]]], col + num_len, sum + x)
          {false, false} -> stride([line1 | [line2 | [line3 | grid]]], col + num_len, sum)
          {true, true} -> stride([line2 | [line3 | grid]], 1, sum + x)
          {false, true} -> stride([line2 | [line3 | grid]], 1, sum)
        end
    end
  end

  def stride([_line1 | [_line2 | []]], _col, sum) do
    sum
  end
end
