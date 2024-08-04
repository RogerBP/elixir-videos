defmodule Servidor.Rewriter do
  alias Servidor.Conv
  def rewrite(%Conv{path: "/livros"} = conv), do: %{conv | path: "/books"}
  def rewrite(%Conv{path: "/jogos"} = conv), do: %{conv | path: "/games"}
  def rewrite(%Conv{path: "/tabuleiros"} = conv), do: %{conv | path: "/board-games"}
  def rewrite(conv), do: conv
end
