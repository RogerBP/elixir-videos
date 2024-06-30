defmodule Servidor do
  @moduledoc "Servidor Elixir de Livros / Jogos e Jogos de Tabuleiro"

  @doc "Função de teste de request"
  def testar(recurso) do
    exec_request("GET /#{recurso}")
  end

  def testar(recurso, item) do
    exec_request("GET /#{recurso}/#{item}")
  end

  defp exec_request(comando) do
    request = """
    #{comando} HTTP/1.1
    Host: sabecontar.com
    User-Agent: Browser/1.0
    Accept: */*

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
