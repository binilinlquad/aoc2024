defmodule Solution do

defp read() do
  File.read!("input.txt")
end

defp parse_input(input) do
  [rels, seqs] = String.split(input, ["\n\n"], trim: true)
  {String.split(rels, ["|", "\n"], trim: true) |> Enum.chunk_every(2) |> Enum.group_by(fn [left, _ ] -> left end, fn [_, right] -> right end), 
    String.split(seqs, ["\n"], trim: true) |> Enum.map(&String.split(&1, [","], trim: true))} 
end

defp input() do 
  read()|>parse_input()
end

defp well_ordered?(rels, seq) do 
  Enum.with_index(seq, 1)
    |> Enum.reduce(true, fn {element, index}, acc -> acc && Enum.all?(Enum.drop(seq, index), fn e ->  e in rels[element] end) end)
end

defp median(seq) do
  Enum.fetch!(seq, ceil(Enum.count(seq)/2)-1)
end

defp fix_order(rels, seq) do
  Enum.map(seq, fn element -> {element, Enum.count(Enum.filter(seq, &(&1 in rels[element])))} end)
    |> Enum.sort(fn {_, ord1}, {_, ord2} -> ord1 >= ord2 end)
    |> Enum.map(fn {element, _} -> element end)
end

def part1() do
  {rels, seqs} = input()
  Enum.filter(seqs, &well_ordered?(rels, &1))
    |> Enum.map(&median(&1))
    |> Enum.map(&String.to_integer/1)
    |> Enum.sum()
end

def part2() do
  {rels, seqs} = input()
  Enum.filter(seqs, &(not well_ordered?(rels, &1)))
    |> Enum.map(&fix_order(rels, &1))
    |> Enum.map(&median(&1))
    |> Enum.map(&String.to_integer/1)
    |> Enum.sum()
end

end
