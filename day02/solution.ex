defmodule Solution do
  def read do
    File.stream!("input.txt")  
  end

  defp diffs(list) do 
    Enum.zip_with([list, Enum.drop(list,1)], fn [a,b] ->  a - b end)
  end 
 
  defp safe?(list) do
    diffs = diffs(list)
    one_direction_only = Enum.all?(diffs, &(&1 > 0)) || Enum.all?(diffs, &(&1 < 0)) 
    valid_adjacent_difference = Enum.all?(diffs, &(abs(&1) >= 1 && abs(&1) <= 3))
    one_direction_only && valid_adjacent_difference
  end

  def part1 do
    read()
      |>Stream.map(fn line -> String.split(line) |> Enum.map(&String.to_integer(&1)) end)
      |>Stream.map(&(safe?(&1)))
      |>Enum.to_list()
      |>Enum.count(&(&1))
  end

  defp safe3?(list, index, size) do
    new_list = List.delete_at(list, index) 
    report_safe = safe?(new_list) 
    if report_safe == false && index < size - 1 do
      safe3?(list, index + 1, size)
    else
      report_safe
    end
  end

  defp safe3?(list) do
    report_safe = safe?(list) 
    if report_safe == false do
      safe3?(list, 0, Enum.count(list))
    else
      report_safe
    end
  end

  def part2 do
    read()
      |>Stream.map(fn line -> String.split(line) |> Enum.map(&String.to_integer(&1)) end)
      |>Stream.map(fn list -> safe3?(list) end)
      |>Enum.to_list()
      |>Enum.count(&(&1))
  end
end
