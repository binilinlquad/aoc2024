defmodule Solution do
  defp read do
    File.stream!("input.txt")  
  end

  defp count_e(table, row, column, size) do
    if (column <= size - 4) do 
      row1 = Enum.at(table, row) 
      if ("X" == String.at(row1, column) && "M" == String.at(row1, column+1) && "A" == String.at(row1, column+2) && "S" == String.at(row1, column+3)) do
        1
      else
        0
    end 
    else
      0
    end
  end

  defp count_w(table, row, column, _size) do
    if (column-3 >= 0) do 
      row1 = Enum.at(table,row)
      if ("X" ==  String.at(row1, column) && "M" == String.at(row1,column-1) && "A" == String.at(row1,column-2) && "S" == String.at(row1,column-3)) do
        1
      else 
        0
      end
    else
      0
    end
  end

  defp count_n(table, row, column, _size) do
    if (row-3 >= 0) && "X" ==  String.at(Enum.at(table, row), column) && "M" == String.at(Enum.at(table,row-1),column) && "A" == String.at(Enum.at(table,row-2),column) && "S" == String.at(Enum.at(table,row-3),column) do
      1
    else
      0
    end
  end

  defp count_s(table, row, column, size) do
    if (row <= size-4) && "X" ==  String.at(Enum.at(table,row),column) && "M" == String.at(Enum.at(table,row+1),column) && "A" == String.at(Enum.at(table,row+2),column) && "S" == String.at(Enum.at(table,row+3),column) do
      1
    else
      0
    end
  end

  defp count_nw(table, row, column, _size) do
    if (column-3 >= 0 && row-3 >= 0) && "X" ==  String.at(Enum.at(table,row),column) && "M" == String.at(Enum.at(table,row-1),column-1) && "A" == String.at(Enum.at(table,row-2),column-2) && "S" == String.at(Enum.at(table,row-3),column-3) do
      1
    else
      0
    end
  end

  defp count_ne(table, row, column, size) do
    if (column <= size-4 && row-3 >= 0) && "X" ==  String.at(Enum.at(table,row),column) && "M" == String.at(Enum.at(table,row-1),column+1) && "A" == String.at(Enum.at(table,row-2),column+2) && "S" == String.at(Enum.at(table,row-3),column+3) do
      1
    else
      0
    end
  end

  defp count_se(table, row, column, size) do
    if (column <= size-4 && row <= size - 4) && "X" ==  String.at(Enum.at(table,row),column) && "M" == String.at(Enum.at(table,row+1),column+1) && "A" == String.at(Enum.at(table,row+2),column+2) && "S" == String.at(Enum.at(table,row+3),column+3) do
      1
    else
      0
    end
  end

  defp count_sw(table, row, column, size) do
    if (column-3 >= 0 && row <= size- 4) && "X" ==  String.at(Enum.at(table,row),column) && "M" == String.at(Enum.at(table,row+1),column-1) && "A" == String.at(Enum.at(table,row+2),column-2) && "S" == String.at(Enum.at(table,row+3),column-3) do
      1
    else
      0
    end
  end

  defp count_x_mas(table, size) do
    Enum.sum(
    List.flatten(
      Enum.map(0..size-1, fn row -> 
        Enum.map(0..size-1, fn column ->
          count_n(table, row, column, size) +
          count_e(table, row, column, size) +
          count_w(table, row, column, size) +
          count_s(table, row, column, size) +
          count_nw(table, row, column, size) +
          count_ne(table, row, column, size) + 
          count_se(table, row, column, size) +
          count_sw(table, row, column, size)
        end)
      end)))
  end 

  def part1() do
    read() 
      |>Enum.to_list()
      |>count_x_mas(140)
  end

  defp count_x(table, row, column)  do
    str = String.at(Enum.at(table, row-1), column-1) <> String.at(Enum.at(table, row), column) <> String.at(Enum.at(table, row+1), column+1)
    str2 = String.at(Enum.at(table, row-1), column+1) <> String.at(Enum.at(table, row), column) <> String.at(Enum.at(table, row+1), column-1)
    if (("MAS" == str) || ("SAM" == str)) && (("MAS" == str2) || ("SAM" == str2)) do
      1
    else
      0
    end
  end

  defp count_xmas(table, size) do
    Enum.sum(
    List.flatten(
      Enum.map(1..size-2, fn row -> 
        Enum.map(1..size-2, fn column ->
          count_x(table, row, column) 
        end)
      end)))
  end 

  def part2() do
    read()
      |>Enum.to_list()
      |>count_xmas(140)
  end

end
