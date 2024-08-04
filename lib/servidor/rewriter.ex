defmodule Servidor.Rewriter do
  def rewrite(%{path: "/livros"} = conv), do: %{conv | path: "/books"}
  def rewrite(%{path: "/jogos"} = conv), do: %{conv | path: "/games"}
  def rewrite(%{path: "/tabuleiros"} = conv), do: %{conv | path: "/board-games"}
  def rewrite(conv), do: conv
end
