defmodule Servidor.Messenger do
  def async_rank(rank_pos) do
    parent = self()
    spawn(fn -> send(parent, {self(), Servidor.BooksApi.get_ranking(rank_pos)}) end)
  end

  def get_msg(pid) do
    receive do
      {^pid, msg} -> msg
    end
  end
end
