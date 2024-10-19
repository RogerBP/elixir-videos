defmodule Servidor.Messenger do
  def async(fun) do
    parent = self()
    spawn(fn -> send(parent, {self(), :result, fun.()}) end)
  end

  def await(pid) do
    receive do
      {^pid, :result, msg} -> msg
    end
  end
end
