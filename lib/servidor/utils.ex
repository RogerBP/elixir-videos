defmodule Servidor.Utils do
  # def list_to_map([head | tail], map) do
  #   head_list = String.split(head, ": ")
  #   [key, value] = head_list
  #   new_map = Map.put(map, key, value)
  #   list_to_map(tail, new_map)
  # end

  # def list_to_map([], map), do: map

  def list_to_map(list, map) do
    Enum.reduce(list, map, fn head, map_acc ->
      head_list = String.split(head, ": ")
      [key, value] = head_list
      Map.put(map_acc, key, value)
    end)
  end
end
