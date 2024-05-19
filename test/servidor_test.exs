defmodule ServidorTest do
  use ExUnit.Case
  doctest Servidor

  test "greets the world" do
    assert Servidor.hello() == :world
  end
end
