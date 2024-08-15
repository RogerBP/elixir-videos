defmodule Servidor do
  @moduledoc "Servidor Elixir de Livros / Jogos e Jogos de Tabuleiro"

  @doc "Função de teste de request"
  def get(recurso) do
    exec_request("GET /#{recurso}")
  end

  def get(recurso, item) do
    exec_request("GET /#{recurso}/#{item}")
  end

  def post() do
    exec_request("POST /books", "name=Os primeiros casos de Poirot&author=Agatha Christie")
  end

  defp exec_request(comando, body \\ "") do
    request = """
    #{comando} HTTP/1.1
    Host: sabecontar.com
    User-Agent: Browser/1.0
    Accept: */*
    Content-Type: application/x-www-form-urlencoded
    Content-Length: #{byte_size(body)}

    #{body}
    """

    IO.puts(IO.ANSI.clear())
    response = Servidor.Handler.handle(request)
    IO.puts("==========================================")
    IO.puts(response)
    IO.puts("==========================================")
  end

  @server_name "Servidor Elixir de Livros / Jogos e Jogos de Tabuleiro"

  def constante_a do
    IO.puts(@server_name)
  end

  @server_name "Elixir Server of Books / Games e Board-games"

  def constante_b do
    IO.puts(@server_name)
  end
end
