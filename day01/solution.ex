defmodule Solution do
  def read do
    case File.read("input.txt") do
      {:ok, body} -> String.split(body)
                      |>Enum.map(fn i -> String.to_integer(i) end)
                      |>Enum.chunk_every(2)
    end
  end

  def part1 do
    read()
      |>Enum.reduce([[], []], fn [l,r], [acc1, acc2] -> [[l|acc1], [r|acc2]] end) 
      |>Enum.map(fn e -> Enum.sort(e) end)
      |>Enum.zip_reduce([], fn [a,b], acc -> [abs(a-b) | acc] end)
      |>Enum.sum()
  end

  def part2 do
    read()
        |>Enum.reduce([MapSet.new(), %{}], fn [l,r], [set, map] -> [MapSet.put(set, l), Map.update(map, r, 1, fn current_value-> current_value + 1 end)] end) 
        |>then(fn [set, map] -> Enum.map(Map.keys(map), fn e -> if(MapSet.member?(set, e), do: Map.get(map, e) * e, else: 0) end) end)
        |>Enum.sum()
  end

end
