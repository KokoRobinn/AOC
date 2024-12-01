defmodule Day1 do

  def main do
    pattern = :binary.compile_pattern([" ", "\n"])
    input = File.read!("inputs/day1.inp") |> String.split(pattern) |> List.delete_at(-1) |> IO.inspect() 
    %{true => left, false => right} = make_heaps(%{true => Heap.new, false => Heap.new}, input, true)
    sum = diff_sum(left, right, 0)
  end

  def diff_sum(_left, %Heap{data: nil}, sum) do
    sum
  end

  def diff_sum(left, right, sum) do
    {left_num, right_num} = {Heap.root(left), Heap.root(right)}
    diff = abs(left_num - right_num)
    diff_sum(Heap.pop(left), Heap.pop(right), sum + diff)
  end

  def make_heaps(heaps, [], _left) do
    heaps
  end

  def make_heaps(heaps, [num | input], left) do
    new_heap = heaps[left] |> Heap.push(String.to_integer(num))
    make_heaps(%{heaps | left => new_heap}, input, not left)
  end
end
