defmodule Solution do
  def read do
    File.stream!("input.txt")  
  end

  def part1 do
    read()
      |> Stream.flat_map(&(Regex.scan(~r/mul\((\d+),(\d+)\)/, &1)))
      |> Stream.map(&(List.flatten(&1)))
      |> Stream.map(&(List.delete_at(&1, 0)))
      |> Stream.map(&(Enum.map(&1, fn x -> String.to_integer(x) end)))
      |> Enum.to_list()
      |> Enum.reduce(0, fn [a,b], acc -> a * b + acc end)
  end

  def part2 do
    read()
      |> Stream.map(&Regex.replace(~r/\n/, &1, ""))
      |> Enum.join()
      |> then(&Regex.replace(~r/don't\(\).*do\(\)/U, &1, ""))
      |> then(&Regex.scan(~r/mul\((\d+),(\d+)\)/, &1))
      |> Stream.map(&(List.delete_at(&1, 0)))
      |> Stream.map(&(Enum.map(&1, fn x -> String.to_integer(x) end)))
      |> Enum.to_list()
      |> Enum.reduce(0, fn [a,b], acc -> a * b + acc end)
  end

end
