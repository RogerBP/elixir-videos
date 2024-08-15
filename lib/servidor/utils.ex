defmodule Servidor.Utils do
  def list_to_map([head | tail], map) do
    head_list = String.split(head, ": ")
    [key, value] = head_list
    new_map = Map.put(map, key, value)
    list_to_map(tail, new_map)
  end

  def list_to_map([], map), do: map
end
